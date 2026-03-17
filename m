Return-Path: <dmaengine+bounces-9461-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIHPNzkSuWm8pAEAu9opvQ
	(envelope-from <dmaengine+bounces-9461-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 09:35:05 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB962A5BC5
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 09:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FB623002E5B
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 08:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694B3345724;
	Tue, 17 Mar 2026 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msBv97hr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0486C33064A
	for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 08:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773736379; cv=none; b=C76ocV9w0YAZ7VELyi1O1b3o80SU3ifV6tQrD6aBMc7DmUEcq2jFEZzWr5cIFq9bSPw5l+tdxLuSGn+cXfiDsM+N6MMgdw72eErqQlbcdQKZPq6+EID9j9WJoKu00HsTB5zP5c/a+awWV/5PznWp1Aa+n5eLQqwvxQ16Mo8aC3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773736379; c=relaxed/simple;
	bh=/GZth/LPL+fzw+HMMo/jkarMS/45eyCkhxuSclcxgyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GcGdMaODRAZv5n0cDdbv/ILYdlot+6DlrUudqwY5qP5iA8rtaL6BSvc36SNf58dBR8B3rVrmLa5/HCWBAt6ezGCdTz9ZgCMzH/9fM0QrAPPTnT0U6K8TT3swQUCqTm5H7OKF+iG4es3PM+LT1iiKnVMd3BoMI8wwR4M1SMkOUds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msBv97hr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so47834575e9.0
        for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 01:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773736376; x=1774341176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5hRZs/lbNYe3uAsAQclai+bpHV+lmvhw5DW5oA0dLHU=;
        b=msBv97hrGmCpcDt3TxxdaYrE27xkj8iOnjl5OUVWgMG0U3dcF16rtwZcyJkLNfWdN+
         kuzufJFZOZVxBe83I/bp4OiSe4t7QjrfPiRD0LEw2hyP64FiX+xD2wtEGnIyE1U63dVv
         iS6buNT6e1QayRnQ3oaGTi/MMwVl/JOuAG9z3RjHGo8ioOJ+H8PHP8fFQuI9PeQL+5hu
         fF/KU5NRWBWE7n59yBKHZRKbOXxqZcfIy2KdjoOqgkgj0fgmBvbkspocuvjQdiA2POiB
         RYsWmNOZZ09tTfNwW+V+pN92imtyMZz6I6X9ryT49BJCovkqj7XLsY/olIWam81QxcFX
         7Nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773736376; x=1774341176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hRZs/lbNYe3uAsAQclai+bpHV+lmvhw5DW5oA0dLHU=;
        b=D4qdljwUtwfxd9rVZykesm1fZRaW/X47XWYsfnEbPXAGDdTAadWCM9+Ug8xx7OLrE6
         Ma9X7UYh38UvyU2qqOkwlrwpNB+lrjCKJ88VK48yqy+XB6XVFH0/I5L90TFVHY7kSkqg
         C7hwnWPZ16KVo92MG8xWWvhwVv84b3z8mIGaCPVJdIk90PEz6a1b2wEZllGjcVkzAcIA
         0TN+8uBmHYmESUDMzsGCNdqAoBmRtOFohY3nv1tDBe2Gw5ieTWEzsCLNRj3Ki6Iq5kuf
         exjhkV7PF1IHdCIFjYNtKAtaTFwTatnJkOmhIRPQxs0P/GTOnRTx0lIkXRSm8jIZO+lO
         qAkw==
X-Gm-Message-State: AOJu0YyFapWIijZvXvqOcrh8WKdD7pE2fv/9X8t8TIU8w8A7aB+9+uj8
	4owlb6Xcy5KZ4rIxuE1dSH7AyukciP8YqaTeehNGi9ct+/uIPRCXjUJC
X-Gm-Gg: ATEYQzyYkhS9pRFqXqQJEJQS4hCi5toRgq4MOtJcz7Pp0AXl1D6ja+7qok6xs3m/zJ6
	r/cpI5hU59X1Los9VEqceHUiffW6/PHHM72CEqd+tkuxSfDndI20GaSagQPT5lr15w0U9LdeRLq
	Hp3FF1SnkYJjVvZS9Bs1sM8k929IbkBrmVEVJjvNg8+Wrn01XlE3TkdB4JNjmWuC7eAqTOK3h1d
	B2b7L34Fnqn8aMKzLTk/6PclqwHOqKMtKchbvzsD7UYc6MU7NaCZA1ppD4Y+XY3UYKeaI40HZC5
	QRz4Yjta76yr+j3g9t3qEGD2vRxZdxjtaLyUaicWO4QNJFYdtTVdPvL+d8GdEPjDw7di2k6H3b4
	/+B389FefdnI8IXtS7+wgGvUdXQcd+Cev8tYTpv2knrjFaekD/CQccTQ/kD5DEk/tQQFX9vEg/A
	p+WudeCwl/VyW/b887UBENGDBWOZhfI9GsmMZz+w2Br1LFdKgqA8gD26JqYdWS5I7TJEzZDODxx
	2x8cj4ts9Dp
X-Received: by 2002:a05:600c:c3db:10b0:485:303b:c50a with SMTP id 5b1f17b1804b1-485566d6fe2mr197888455e9.13.1773736376063;
        Tue, 17 Mar 2026 01:32:56 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8fad1sm92617025e9.1.2026.03.17.01.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 01:32:55 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Kelvin Cao <kelvin.cao@microchip.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] dmaengine: switchtec-dma: fix FIELD_GET misuse when programming SE threshold
Date: Tue, 17 Mar 2026 08:32:52 +0000
Message-ID: <20260317083252.13224-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-9461-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5BB962A5BC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

FIELD_GET(SE_THRESH_MASK, thresh) extracts bits [31:23] from thresh and
right-shifts them, which is the inverse of the intended operation. Since
thresh is derived from se_buf_len / 2 (at most 255), bits [31:23] are
always zero, so the SE threshold is never actually programmed into the
register.

Use FIELD_PREP() instead to correctly left-shift thresh into bits [31:23]
of the valid_en_se register, consistent with the FIELD_PREP usage for
the perf tuner config just above.

Fixes: 30eba9df76ad ("dmaengine: switchtec-dma: Implement hardware initialization and cleanup")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/dma/switchtec_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index 3ef928640615..71d9868ce613 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1099,7 +1099,7 @@ static int switchtec_dma_chan_init(struct switchtec_dma_dev *swdma_dev,
 	dev_dbg(&pdev->dev, "Channel %d: SE buffer count %d\n", i, se_buf_len);
 
 	thresh = se_buf_len / 2;
-	valid_en_se |= FIELD_GET(SE_THRESH_MASK, thresh);
+	valid_en_se |= FIELD_PREP(SE_THRESH_MASK, thresh);
 	writel(valid_en_se, &swdma_chan->mmio_chan_fw->valid_en_se);
 
 	/* request irqs */
-- 
2.53.0


