Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEE6E1074
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2019 05:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731712AbfJWDVI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Oct 2019 23:21:08 -0400
Received: from sender4-pp-o94.zoho.com ([136.143.188.94]:25466 "EHLO
        sender4-pp-o94.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfJWDVI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Oct 2019 23:21:08 -0400
X-Greylist: delayed 930 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Oct 2019 23:21:07 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1571799948; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=CwQbYnVGK6JbEVTd9NtY96mgOIX0S+1ATTxhKH6VxhNzWUnsqqcDB0OZHWcZwcp3mbH9V5BqvHHf0MOPiX91Tw3Z5aRCxyKnKL4LSv6SsDlJ4siMmQpq6dTwQb4kZUwhMhtFFuN5B3Q3M/w3Nn73za1nSi1KZo5SvB0srFM/pBA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1571799948; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To; 
        bh=A/dWkEZHy42hUUFI5RXmIqSsQ6EBJgvvYOFnxw/N3t4=; 
        b=Eh2bimbhGUK1gwV1cbkQMGalwW3rTZnKoiiVQl1SLWmVy1+Ko/cp3gTza0I7Dn12y2TweUbxWA17sQPxhy50BhjUnWhqHFryX2avFmQo5u5dfZl91Lb6K69y+1Jw5AYMx/7SQNn1eHaTi+2FqFQDz/oOArXo84R5twIB7KLbGwY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=neLtYkaMBFP1gAOPQuIsPSE3OhcyzIhcENIuUYhFXPQCKAc5an/KZWbTWD7y4qzj9MW6tOKT0n3m
    h+GTfZXTDBIevAFmBsGiMiaeJjuzUMAhJGsuzxyTJnQyWmxuylGr  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571799948;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=1209; bh=A/dWkEZHy42hUUFI5RXmIqSsQ6EBJgvvYOFnxw/N3t4=;
        b=CR8UgsX/Hty7kc2s+vlfAcUNwUQF8BDLekPCoqA61JtdnZhoKJIgSUME1WANanqK
        0jqrq0af12Fp1zDvF7Tthk+oZF92VnOl0iuYFTIvxdgp81Q9QSQKNoUU8matWmIhV7C
        vW7u2Babilr8yvR7QWQdVWmrTrHhHv5VfWotQbi0=
Received: from zhouyanjie-virtual-machine.lan (182.148.156.27 [182.148.156.27]) by mx.zohomail.com
        with SMTPS id 1571799946481488.59997078669005; Tue, 22 Oct 2019 20:05:46 -0700 (PDT)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, vkoul@kernel.org, paul@crapouillou.net,
        mark.rutland@arm.com, Zubair.Kakakhel@imgtec.com,
        dan.j.williams@intel.com
Subject: [PATCH 2/2] DMA: JZ4780: Add support for the X1000.
Date:   Wed, 23 Oct 2019 11:05:03 +0800
Message-Id: <1571799903-44561-3-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571799903-44561-1-git-send-email-zhouyanjie@zoho.com>
References: <1571799903-44561-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for probing the dma-jz4780 driver on the X1000 Soc.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 drivers/dma/dma-jz4780.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 7fe9309..c7f1199 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -1012,11 +1012,18 @@ static const struct jz4780_dma_soc_data jz4780_dma_soc_data = {
 	.flags = JZ_SOC_DATA_ALLOW_LEGACY_DT | JZ_SOC_DATA_PROGRAMMABLE_DMA,
 };
 
+static const struct jz4780_dma_soc_data x1000_dma_soc_data = {
+	.nb_channels = 8,
+	.transfer_ord_max = 7,
+	.flags = JZ_SOC_DATA_ALLOW_LEGACY_DT | JZ_SOC_DATA_PROGRAMMABLE_DMA,
+};
+
 static const struct of_device_id jz4780_dma_dt_match[] = {
 	{ .compatible = "ingenic,jz4740-dma", .data = &jz4740_dma_soc_data },
 	{ .compatible = "ingenic,jz4725b-dma", .data = &jz4725b_dma_soc_data },
 	{ .compatible = "ingenic,jz4770-dma", .data = &jz4770_dma_soc_data },
 	{ .compatible = "ingenic,jz4780-dma", .data = &jz4780_dma_soc_data },
+	{ .compatible = "ingenic,x1000-dma", .data = &x1000_dma_soc_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, jz4780_dma_dt_match);
-- 
2.7.4


