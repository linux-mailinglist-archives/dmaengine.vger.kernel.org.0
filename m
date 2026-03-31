Return-Path: <dmaengine+bounces-9783-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLiyJ53iy2n0MAYAu9opvQ
	(envelope-from <dmaengine+bounces-9783-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 17:05:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA2236B597
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 17:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D6FA30CC5FF
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 15:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644EB3E4C66;
	Tue, 31 Mar 2026 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrbW5UJ6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E818436655B
	for <dmaengine@vger.kernel.org>; Tue, 31 Mar 2026 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969316; cv=none; b=Nq+W3Lmd9ETMPF9qMdUWruHumoXODCbjw0ESP9FxiD+CM/JLEmj8kSYoOmEpk0sImRrG2/U2D1y+4gWsQqBCMXvxJ+10IPFqLdmSHkViIGkUOZEQJEZg9KyWO0FVtMMsXEdfzJqua2+sLKykd028MIETvz4+2B+o5Dj5bd5bKsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969316; c=relaxed/simple;
	bh=DcEJ4U7Yyq+Cm6EOMCWocg9knrI71L5rKYP3dH8uE3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RoAz1ddBIfXU++xwKTc5rjz0mtXFYbUcQ1CqDA67TqaZZXrjQeA02fVpvu2XFayEgyMVm7SRnIhPw3K92hrRZ0wq5QLxy3q70b5EkKTfmzyQIQTxXeSfE75mHjVJxmaozGG17S/a1FaWi/ADmIB1cvhGNpqyMGZyjLGGWcKxhyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrbW5UJ6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48704db565eso73154345e9.1
        for <dmaengine@vger.kernel.org>; Tue, 31 Mar 2026 08:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774969313; x=1775574113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4CagzxLlAGLfocRZ9LE77D/o4zwZP7Z1xANJIRVeJc=;
        b=jrbW5UJ68YUAL3UIgKKDSdXjFkuJYXjXlMvaB1dspeYCQ+Wgr76Ie/1J/XNceVLvmJ
         hjHbe/j2DBHSIwe6csHv+khHsAsCDIAuStlI6Rv1xJDxEOhtnjaN9Zs+JFTT3vMJf3PK
         czlsUswMkl93OH9hPpawXCFwOP4mBfXZAyIYssC8hxQlQQF++adpWNMZn+Q3HEL0rG+9
         TIAsebxmAUx9kTcqu1oY7jB0XIxSnRam3isqa4BqpKmEUsldGGRA1QHWNkUhVYHe1uXc
         oZxd4bbeg4DI3W7SLkhgNsQOVKbT4czTyzIGfhlgHx0jJHYV3/6nqn+RrSSNXBDzRa/4
         SfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774969313; x=1775574113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D4CagzxLlAGLfocRZ9LE77D/o4zwZP7Z1xANJIRVeJc=;
        b=Z+8nCrc45XPurqxmNlDPHz1Yge9QXVAKQqvlxwMhE0uuVnRZzohkUibswCVmuwL8SU
         Imb9ZDDAbELKF+T/m35wJrVH18/HMc8LapngcRm1sDLHUjDGtbZih5bjToYr9DOFNj/4
         ROWAGKAgMcNgNmOF6+OAiapl6L9BdidDk1mN7eblgmwnTj7g+bnTrIYlqS27dx2LHkEd
         rEttvep3Yv+aIK0v3tc3OBg/YtAlLaM4Lxlv8JwkufvCgsVwC9+c7+t6oPqF96yVOEDX
         qWhyahETPV+BwrpP03LsBQRRrdEDs+bZxXBGQfin/cDe5YKzm2bq0BA5W1Nt8zefwRNL
         lWrA==
X-Gm-Message-State: AOJu0YzfUTa0qgmOqFtOjWYBN3f8ySyYR1b46P++Pn2XGEaoBa0wyFmS
	zILgQwm7O+008IJfB41EAnfOL+/T3tAIWO0LP2dsBAwyG2Cx1NDUKfDj
X-Gm-Gg: ATEYQzyUnlrrEj+P6Wl0xdQ0V1Lc86uj7uMyL9rjStX7N8Bhcv+Ivm8O3JdWlv1EdvG
	VuSrD2BJBkdfLxWM1UkGUhEBRicCL/UFvifTcP+x00kwSa1jJL/RTF7nCsRPhGLWoejgYxSH6TO
	D1gJAut6BIcWlqdMe0fcUresWI8yzSdfnuy7FBK5ptKMABUFFU7tp/9m5/ImnpzeI0I2ESChKaU
	XntND1rqgeGUpp4mGsk199ZpMfGr28QuNT6ojebu6mzUFpsA7D4Bd7mwFcKDjTmYvpbzi2a2Ehg
	DPvl6sb95zhy31sfsFCloJ/ips536fNG4iLOgsiNUg47PEr2gW7sTU+/811lmaKtfwZ2yUXN+SK
	27Xbbj4E+fK0B2hjoPAxC53HkE0X3FiWvm9gn2K/fTRuCB/P7u0bE21zv37ZIRAlq2P5qLv+mPn
	UgRVaDan3WChSULgLP4pzEZVTpmCQAmsSSlF7fGVNCldXIrk+u8JSDeVAmjeHCivzD89KuSJl+P
	mnlKKXduvlk
X-Received: by 2002:a05:600c:3145:b0:485:ae14:8173 with SMTP id 5b1f17b1804b1-48727d4593amr294151465e9.1.1774969312789;
        Tue, 31 Mar 2026 08:01:52 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a63esm56178585e9.3.2026.03.31.08.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:01:52 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Frank Li <Frank.Li@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Vinod Koul <vkoul@kernel.org>,
	Yingkun Meng <mengyingkun@loongson.cn>
Cc: dmaengine@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v2] dmaengine: loongson: loongson2-apb: fix broken bus width validation in ls2x_dmac_detect_burst()
Date: Tue, 31 Mar 2026 16:01:49 +0100
Message-ID: <20260331150149.635688-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <acqkrL7CYbr0WmHf@lizhi-Precision-Tower-5810>
References: <acqkrL7CYbr0WmHf@lizhi-Precision-Tower-5810>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-9783-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0CA2236B597
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The bus width validation check in ls2x_dmac_detect_burst() compares raw
enum dma_slave_buswidth values (e.g. 4, 8) directly against
LDMA_SLAVE_BUSWIDTHS, which is a BIT()-encoded bitmask
(BIT(4) | BIT(8) = 0x110). Since 4 & 0x110 == 0 and 8 & 0x110 == 0,
the condition is always false for valid bus widths, making the
validation dead code.

Additionally, the logic was inverted: it rejected configurations where
both widths matched valid values, rather than rejecting when neither
width is supported.

Fix by comparing directly against the supported enum values, avoiding
BIT() which would overflow for large dma_slave_buswidth values like
DMA_SLAVE_BUSWIDTH_128_BYTES. Invert the logic to reject when neither
width is supported by the hardware.

Fixes: 71e7d3cb6e55 ("dmaengine: ls2x-apb: New driver for the Loongson LS2X APB DMA controller")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/dma/loongson/loongson2-apb-dma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/loongson/loongson2-apb-dma.c b/drivers/dma/loongson/loongson2-apb-dma.c
index aceb069e71fc..d219f40cb0ae 100644
--- a/drivers/dma/loongson/loongson2-apb-dma.c
+++ b/drivers/dma/loongson/loongson2-apb-dma.c
@@ -220,8 +220,10 @@ static size_t ls2x_dmac_detect_burst(struct ls2x_dma_chan *lchan)
 	u32 maxburst, buswidth;
 
 	/* Reject definitely invalid configurations */
-	if ((lchan->sconfig.src_addr_width & LDMA_SLAVE_BUSWIDTHS) &&
-	    (lchan->sconfig.dst_addr_width & LDMA_SLAVE_BUSWIDTHS))
+	if (lchan->sconfig.src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES &&
+	    lchan->sconfig.src_addr_width != DMA_SLAVE_BUSWIDTH_8_BYTES &&
+	    lchan->sconfig.dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES &&
+	    lchan->sconfig.dst_addr_width != DMA_SLAVE_BUSWIDTH_8_BYTES)
 		return 0;
 
 	if (lchan->sconfig.direction == DMA_MEM_TO_DEV) {
-- 
2.53.0


