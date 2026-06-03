Return-Path: <dmaengine+bounces-11149-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4qRvD9F+IGpH4QAAu9opvQ
	(envelope-from <dmaengine+bounces-11149-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 21:21:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9847063ACE7
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 21:21:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=nowuHSFP;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11149-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11149-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24AAD301570A
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2026 19:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFFC38D41A;
	Wed,  3 Jun 2026 19:20:11 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D28B37E2FD
	for <dmaengine@vger.kernel.org>; Wed,  3 Jun 2026 19:20:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780514411; cv=none; b=NsvgvjZHJPTmMi7fqtebM8Brx+W5FmFxIPKF0RReQ3AcUYn/lnZLFYVnT6Y0RYzwqWv69nHjHhwxM6PSZOk7W/Ye0qYOdSez56FA6R96tDiqoYyYFZ2//+ySmpQH/rPthKbXtLhgDs97Rg2JGTWp2AwXD+0KPea2SfWlqSQP+dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780514411; c=relaxed/simple;
	bh=k5ucc/S3MeMvDpFXoS0Zsm72BMUcrkaqC2imEC9YibU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s7CYH9LBnbTOmi5JgSc/uB3N2G6eNglkw/OckL0aR4HIAeOUadQh8szLy6AGOR+Gqlf7IeOfd3iY3QY3dKNWtOZJpPMEf6bgQjIB89oSToP24UCF5jgPZpacjCUhBdrDBuxZER3jgqcWH0tYk4XvFGw/qtcqwv8SKfLRNdX11Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nowuHSFP; arc=none smtp.client-ip=209.85.215.177
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c858014845aso475805a12.1
        for <dmaengine@vger.kernel.org>; Wed, 03 Jun 2026 12:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780514410; x=1781119210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KwYMAaLF5mHYedGImt+0WHoMwy3yyjRd6iX6DU10JXs=;
        b=nowuHSFP9eFLB53iWLPqicgylgbsJrLT3qtooKEgpXFE+4WMjTPtCIv7FlwppKfNyx
         Hj/7GMZO5SFjZKJO9+f0e3v4sCmhm17FQ3pA5vy36IJWzsTY3ilVVDnyMEJcnGMPZevy
         uLBV1PQTDf1Hs/coVn+tuHT4J6Q8KKfFVXnQfZcm+d+JL8rIVpRIwGzaTJCeGmd1KXDH
         x8orOWt/q2qIujnbULB+7NbCRVgy1Ttr4r8OVdh7O2UXKmVRbhFoNbsYpIHVGXMjrImk
         8ysEkoBv8GOvlgq36Xt0dx66sOSaXPBKpD6CVQOVcI5gv8PjKZ2Z5fw7G8k2NLGdVSu0
         +isQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780514410; x=1781119210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwYMAaLF5mHYedGImt+0WHoMwy3yyjRd6iX6DU10JXs=;
        b=LFzUWdOSjbWIdl9a4bIIpIPdncKq+8iSt26Xk+GdVfYF4Lhkq8+6KyRn04BmM1vrVi
         5y8seiKCZYg/9r/NKFJVg48VCORAKqGJA1dGHJP8AvG8dRs0dp3dcQ9IpQ377k3NjzG5
         MgR8qAiFmnhRf30+lKnn3Vom4fJflVZSPrVk/T+evcwsFUgg78zod2IVfnYKaTs4eECS
         Zk0jTageavkw2ivKRrE1kGho4iiCa+V2TMCIrTAVgYnxplO7zLBCA+agt1QVpY6edaHh
         lyp6V5kEvI7PLypCu3zC5ZVeJanGe1adbKYVzla8lp7zl+uOtM+bdTZ3PZsZsl/60rFU
         Z5Tw==
X-Gm-Message-State: AOJu0YyUXW5vmUu2P3rpDfHrSwhz2lYkK61IhpuGxmrq4zlywZOR2avw
	vHrhvaJYQukLyGUUaVR9MWoEf9wjn1UDhVb7RzxIhSWvB9k9hLfEu61cGdpzYqMo
X-Gm-Gg: Acq92OGyX463S7eyXehFHH/QVeuuEvBK/A+/pk5tF/R3ypOwBMFihX8s35JEWraXauy
	Zm7JFJlbCrn3HUkN6jij9DMvExHN2mWojUAVZqdLVJ3L6GC7s0vLBXtMSJ+KLz8OpCbe90GGm0v
	SCynM0aWg/B7BQ2uq2cPEGtTQjesqh2IFmQG6gYXVx+9gYNpSCtn7d4awjsUWFfu7klppFRukHh
	6LK8QwgeBvuusCEpW0p9u3w6HwddTnom/ku9tRuJumsBnzX9Xsj+AqcIRMrsAUr5uDD+EBXSrnI
	hi0boMhL3G81vqVFvuxMFOIsrA59DEVklVWN7vMVxUDCpmIFStSSJMkJbxd6NI7RqLtm3cMIOZ4
	PiB2+bbdVPhVutg9hSLWJu1CtvmM3qj19TaYs/KqUQ3CY+oXvn737QQAsPFTJbYLsolxaOatRhW
	KMxVUGbEyLAYPqWwvvLhnhgza7P1ExvKEeX+mh84KCZy3cPy0XBE3V55oSDQsPSNH80VbAFnI9D
	GH48Bp6A5hCfrpfUk+HnJLqhN05SM/PHf9N1R+RBVfogw==
X-Received: by 2002:a05:6a21:3995:b0:3b4:6af4:bdd5 with SMTP id adf61e73a8af0-3b4b1e4f9c7mr509069637.15.1780514409663;
        Wed, 03 Jun 2026 12:20:09 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04a0e9sm2548934a12.13.2026.06.03.12.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 12:20:08 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Zhang Wei <zw@zh-kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE DMA DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dma: fsldma: convert to platform_get_irq_optional()
Date: Wed,  3 Jun 2026 12:19:51 -0700
Message-ID: <20260603191951.5729-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11149-lists,dmaengine=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:zw@zh-kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9847063ACE7

Replace the per-controller irq_of_parse_and_map() call with
platform_get_irq_optional(). The controller IRQ is optional — when
absent (-ENXIO) the driver falls back to per-channel IRQs. Any other
error is treated as fatal. The corresponding irq_dispose_mapping()
calls in the probe error path and remove function are removed.

The per-channel IRQ mapping in fsl_dma_chan_probe() uses a child
device_node rather than the platform device's of_node, so it is not
converted here.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/fsldma.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 98d02809ade5..08a8090178f8 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1239,7 +1239,16 @@ static int fsldma_of_probe(struct platform_device *op)
 	}
 
 	/* map the channel IRQ if it exists, but don't hookup the handler yet */
-	fdev->irq = irq_of_parse_and_map(op->dev.of_node, 0);
+	fdev->irq = platform_get_irq_optional(op, 0);
+	if (fdev->irq < 0) {
+		if (fdev->irq != -ENXIO) {
+			err = fdev->irq;
+			iounmap(fdev->regs);
+			kfree(fdev);
+			return err;
+		}
+		fdev->irq = 0;
+	}
 
 	dma_cap_set(DMA_MEMCPY, fdev->common.cap_mask);
 	dma_cap_set(DMA_SLAVE, fdev->common.cap_mask);
@@ -1301,7 +1310,6 @@ static int fsldma_of_probe(struct platform_device *op)
 		if (fdev->chan[i])
 			fsl_dma_chan_remove(fdev->chan[i]);
 	}
-	irq_dispose_mapping(fdev->irq);
 	iounmap(fdev->regs);
 out_free:
 	kfree(fdev);
@@ -1323,7 +1331,6 @@ static void fsldma_of_remove(struct platform_device *op)
 		if (fdev->chan[i])
 			fsl_dma_chan_remove(fdev->chan[i]);
 	}
-	irq_dispose_mapping(fdev->irq);
 
 	iounmap(fdev->regs);
 	kfree(fdev);
-- 
2.54.0


