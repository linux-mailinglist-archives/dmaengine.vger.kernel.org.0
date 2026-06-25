Return-Path: <dmaengine+bounces-11783-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q/RaJV86PWo/zggAu9opvQ
	(envelope-from <dmaengine+bounces-11783-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 16:25:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FCE6C69C1
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 16:25:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Y9liWUUk;
	dkim=pass header.d=redhat.com header.s=google header.b=MSMSGZfP;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11783-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11783-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D0983017F9D
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 14:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04832364057;
	Thu, 25 Jun 2026 14:22:12 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B119A35E1BD
	for <dmaengine@vger.kernel.org>; Thu, 25 Jun 2026 14:22:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397331; cv=none; b=d5vtafZSRv3m7Xqk1q0SoExNX4NjHnekpqJfTXCyB+ABDhSPucyVZFRVC0Edr+JV08chpgcMYmHmfWAqlMfpWT8bYsyj+8C09ctJoRCLaxvyfHVZ+TjzF0zUaYcuqKCXmo822eADwMygKWHt+1G3eFLNk1UdhZwOLTUufd24sEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397331; c=relaxed/simple;
	bh=7P5OVSlBwQBa2L1a2kIB+WV0bNP9fstAVD5b2d4VczM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tHZMvPoSVe/q1DefI8VxnMjGlUsCssnOyuDBGoch6dctivSMMFui9z62rO++OjIygTTMZQ10qb3Bx2p9x5p+yJBCyNsBrIGIprCdztkoK350IQKJyEEdCb5uHWPTOsIfUY6QsuqwCosgm0XL1qjg/qQZ2/AV4dY7esSXHpeO1Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y9liWUUk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MSMSGZfP; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782397329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B8X7ICklwV+HU//r/zX/JXRLi9ZAF8M6fuhETaloCPY=;
	b=Y9liWUUkLccz97UTvcm9FHa1FZVN5Z5qs/jiyTQWXYknbqqVycQSlX+1+3H/3tts9AILkM
	Ey5A/bumCDuv8x6V22sR8oUQ4WLphWL2CPW9YwjFR1rXalHidU9Ik0gvWJs+yeHS01cPDX
	3UhR6dEe056FkYq7VNvwo10UyG+7NKM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-X7rlFmSFPmGix88k7n2PvQ-1; Thu, 25 Jun 2026 10:22:08 -0400
X-MC-Unique: X7rlFmSFPmGix88k7n2PvQ-1
X-Mimecast-MFC-AGG-ID: X7rlFmSFPmGix88k7n2PvQ_1782397328
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-915c364ae3bso359399685a.0
        for <dmaengine@vger.kernel.org>; Thu, 25 Jun 2026 07:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782397328; x=1783002128; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B8X7ICklwV+HU//r/zX/JXRLi9ZAF8M6fuhETaloCPY=;
        b=MSMSGZfPy+LmvP8rRdCMzG13Vtbg4vGWm+/LMJlZlMPoqasCkv/3Q48sLINucn8lAu
         nfEmTkZhGf4ohMt/UeCY/jFaQ5PZMGPseKr3nbx+RwIKDWb6R7E0MJ2xh2QcTfY0Tx/P
         HfT+i86WSTfXIQCK2hBId81kphjekqhol+cfyuM3qM5TfR78B/aRcDC4ahDWISGIjP35
         hgvbPwK/mFF3M/PDEPD7ftv4Z65guM6vTbjhvMyVO0JnLu36LHs4PIATfZzVZQ545jcD
         rPm6d8IkSJ9InJQBq+4EXoox81RfNKXCOcWTlLhMD2Tl0stK3wPWnL4N0pdcVwSoaRdk
         7SYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782397328; x=1783002128;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8X7ICklwV+HU//r/zX/JXRLi9ZAF8M6fuhETaloCPY=;
        b=XRkFOgQvTeb+jOAENIT6LyDIeEUTnNeHyuP+/ZDwhstJc5/wSNG2kaAoSo7Rc1oXKi
         +PVsCPKJZlSrj7Jf1oi4eiZGwNy1M4GUy0h5EOpICWuV6p3BD/xBOPpiuPxngxhuag1P
         wPMvdKd0r0/yWYVk/e+6UIHd0zL/zNnxXud4WFTMHYuGFbWaP4avzsMBi3aLc36LekKA
         oYetvm4TFP0oTmF6iFQLl8P9JAcqM74q6IvuDcfQRtq2/bIJbmLc5gt1uKIy7FN0xo+x
         zKOk3kINccbIEBqAeBGm64WmPoI8vLvl1DCMDwvlTO9RHo0WghUaDDMZcTwUcpyZ+zJO
         A8TQ==
X-Forwarded-Encrypted: i=1; AFNElJ+jz163JpF5ciQLD3zNX+7i6FnD73qqskQCiJKTNA66nDNHUXCyXaFMHA5F3bFGpMAEgUibophodfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz64Vm4u4uJbLbllwc1V1fEbHPV8zgoQbfbtkzSTtyeiSkEhE5B
	Z2nOdcH5Wx9G2wosz86xRjz9v7RO+d8/4wWQUJ8uJ8lkCPL16uGrWZ/bEYU08W98Vda4Wj/tAe3
	dOqKwvHwWIKBY/zz5PfT5LXmQQdY6Egn92CnAUtAzUzfoWWo1qHbRoU0H99kgXwgDO+BnbA==
X-Gm-Gg: AfdE7clS5C/3+BoS+pur53LxZ+dD/NaLsYBuMObsQ4zjfw4Rw5NwIkHoZ0joCUVfK9n
	n8TL9A4mNIfhVZr6DUCELbsVnOV1Mh1fbq9TwWaKtM+zAoY5aHXllICG9J/FAF5UDWSf3LvpY9W
	Eo3uduSSGS4najeA92+jTKxVopQx5qU0PDNtCw5D075HgYMhqXwGcFj+8xF0R2yeMySpXayDUiN
	jBEF5y9bDVkmkgykUaiz4JfvSfN2RW58hQ6wrIWrlJ+lgZCDN4sxw8mnz2VSKaucIO3ViJ0CQQR
	9FxS/V8oiaW2D5ZHaWEHD8vvTE8JgDDURaXYEXdO5SWv4d8ZmoJj5pIGiUj8c/8Aictkbko1dbH
	i8hNBFYWZWoVC
X-Received: by 2002:a05:620a:46ab:b0:91e:e613:9c5f with SMTP id af79cd13be357-9293c5fcebfmr395647685a.26.1782397327818;
        Thu, 25 Jun 2026 07:22:07 -0700 (PDT)
X-Received: by 2002:a05:620a:46ab:b0:91e:e613:9c5f with SMTP id af79cd13be357-9293c5fcebfmr395640085a.26.1782397327239;
        Thu, 25 Jun 2026 07:22:07 -0700 (PDT)
Received: from [10.1.10.209] ([162.255.191.18])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926000c343bsm851247785a.28.2026.06.25.07.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 07:22:06 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 25 Jun 2026 10:21:36 -0400
Subject: [PATCH] dmaengine: qcom: gpi: correct channel name in error path
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-qcom-gpi-err-fix-v1-1-5ca3f00fe2e3@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bsEsJfpKdIhabQ+lrRCB+Pek4
 wzMZEgkTAmmJoPQw4nDVaFrG9iO9fKEvFcGrbRVVhu8t3Cij4wkgo5fVJZcNw6mt2qEmkWhqv/
 lvJTyAb+kt7liAAAA
X-Change-ID: 20260625-qcom-gpi-err-fix-06ef18453608
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=7P5OVSlBwQBa2L1a2kIB+WV0bNP9fstAVD5b2d4VczM=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLJsLTsnzTy618WQvTYz807Krb8ZK2Y4G3ftX2FZd3xP4
 JGbU1cGdJSyMIhxMciKKbIsyTUqiEhdZXvvjiYLzBxWJpAhDFycAjARd2OG/xWM9ZaLp263L2Z9
 +Poyz7yphzPu9Am+TForN/3eTsNS2+kM/zM91G99nNBg1j3P+faj98/q+5Kn7fu0xMi1afHqCw+
 SdjMCAA==
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11783-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bmasney@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[bmasney@redhat.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmasney@redhat.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03FCE6C69C1

When attempting to start the Fedora graphical installer from a USB
thumbdrive on the Lenovo Thinkpad x13s laptop, the following errors are
shown in dmesg multiple times:

    kernel: gpi 800000.dma-controller: cmd: CH START completion timeout:0
    kernel: gpi 800000.dma-controller: Error with cmd:CH START ret:-5
    kernel: gpi 800000.dma-controller: Error start chan:-5

Looking through the error path, gpi_send_cmd() sends the wrong gchan to
gpi_send_cmd() in gpi_ch_init()'s error path. Let's fix this by passing
the correct gchan.

Fixes: 5d0c3533a19f ("dmaengine: qcom: Add GPI dma driver")
Signed-off-by: Brian Masney <bmasney@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
There's a separate issue with the graphical Fedora installer not
working that I haven't had time to dig into further. I can work
around it by using the text installer.
---
 drivers/dma/qcom/gpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index a5055a6273af..3f390b5821ab 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -1965,12 +1965,12 @@ static int gpi_ch_init(struct gchan *gchan)
 error_start_chan:
 	for (i = i - 1; i >= 0; i--) {
 		gpi_stop_chan(&gpii->gchan[i]);
-		gpi_send_cmd(gpii, gchan, GPI_CH_CMD_RESET);
+		gpi_send_cmd(gpii, &gpii->gchan[i], GPI_CH_CMD_RESET);
 	}
 	i = 2;
 error_alloc_chan:
 	for (i = i - 1; i >= 0; i--)
-		gpi_reset_chan(gchan, GPI_CH_CMD_DE_ALLOC);
+		gpi_reset_chan(&gpii->gchan[i], GPI_CH_CMD_DE_ALLOC);
 error_alloc_ev_ring:
 	gpi_disable_interrupts(gpii);
 error_config_int:

---
base-commit: 6c94b38b83a04c43ea49004275f0391404051093
change-id: 20260625-qcom-gpi-err-fix-06ef18453608

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


