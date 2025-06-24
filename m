Return-Path: <dmaengine+bounces-5610-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FB2AE5DCA
	for <lists+dmaengine@lfdr.de>; Tue, 24 Jun 2025 09:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69CEE3A8374
	for <lists+dmaengine@lfdr.de>; Tue, 24 Jun 2025 07:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321921C5D72;
	Tue, 24 Jun 2025 07:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="otskjeCf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1ED35946;
	Tue, 24 Jun 2025 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750750384; cv=none; b=Pw+tGtxpJl6y09znBhZWO89t5fShs0+bTNMKX+cTqJdCTJrB4jzVW+RwiEzyWmCjwBmfzjx6fop8a+OpvUMQhqo3fd06W0c9/V+LhPI61G9kBdCzVuKmQVgIt/OIIqCTahHSNdS/rfo2l6B4tBIuh+fQ0Lls6qVI7vgph8V3qUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750750384; c=relaxed/simple;
	bh=i/Ol8jMxEi4pHVy0h903kwfq3V4w6RRvwM4KIRBq2W4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=B6pVNocsOn6IjHDyQeQznXJpwCN0HOTaoFaB3MZycSdXXxin3oEeTboC99JndmwxdSaT6ctDLjSlbLn00l6DVW4CSPWoKwk49dtsLkXPaoYDhWz484GpzPnT8HLH03uVxvPX338BrkAaPVbTJ3k+kDXnewqZPGG2hngb35eFFcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=otskjeCf; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O6JuYa019415;
	Tue, 24 Jun 2025 09:32:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=E0Qbsc0rAt1t7y4ukc6Btf
	5nsvzhwyyO68ZK3wJPBe4=; b=otskjeCforBxF8o36rJ1Y4oDWvX6C/dVwZ4KFf
	AdfPJ9EGFwMPPlE3FY3BfULRzSY+fMo32h3D3Z6FTF/nGLOhBKhW/Jv6u8DumG6j
	PUWQhwcF+jqQCsK/n5XorA/bbkLfHqxfdBhXu7VenrtIyqUMEHkTODsZ+oL3soyd
	3cI4DqF7gmPP0gHVejLYrfgWD73Uuk03mrOUQzLMb8XEr8KLwFCIEcf+0g3Pq9kc
	WjkOzT9QVC29kY8JxcDUjapPFSQDxyaDmSdeFqDHttgH98WtnhKWKNu7s+ixgl1A
	t5vKw8HKRWA1TiTvSpaDrA/ZJxiHnEgh+cEU0JJlhZMgD4Zg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47dkmjk2fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 09:32:49 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B3A7E40044;
	Tue, 24 Jun 2025 09:31:44 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6CDFAAC0B47;
	Tue, 24 Jun 2025 09:31:44 +0200 (CEST)
Received: from localhost (10.48.87.237) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:31:44 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Tue, 24 Jun 2025 09:31:37 +0200
Subject: [PATCH RESEND] dmaengine: stm32-dma: configure next sg only if
 there are more than 2 sgs
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250624-stm32_dma_dbm_fix-v1-1-337c40d6c93e@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAFhUWmgC/32NsQ6CMBRFf4W82RJa2mKcGGR10NEQArwiHUpNH
 yEa0n+34QMc77m55+5AJlhDcMl2CGazZP2SAj9lMM798jLMYsogCqEKXShGqytFh67vcHDdZD+
 sHM5aVByVRAlp9w4m4cP5hHvzaG5XaBOfLa0+fI+rjR/tH+vGGWdSalVJXWKFup48UU5rPnoHb
 YzxB4W5a3K8AAAA
X-Change-ID: 20250605-stm32_dma_dbm_fix-3b86271d54d4
To: Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <dmaengine@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_02,2025-06-23_07,2025-03-28_01

DMA operates in Double Buffer Mode (DBM) when the transfer is cyclic and
there are at least two periods.
When DBM is enabled, the DMA toggles between two memory targets (SxM0AR and
SxM1AR), indicated by the SxSCR.CT bit (Current Target).
There is no need to update the next memory address if two periods are
configured, as SxM0AR and SxM1AR are already properly set up before the
transfer begins in the stm32_dma_start_transfer() function.
This avoids unnecessary updates to SxM0AR/SxM1AR, thereby preventing
potential Transfer Errors. Specifically, when the channel is enabled,
SxM0AR and SxM1AR can only be written if SxSCR.CT=1 and SxSCR.CT=0,
respectively. Otherwise, a Transfer Error interrupt is triggered, and the
stream is automatically disabled.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32/stm32-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/stm32/stm32-dma.c b/drivers/dma/stm32/stm32-dma.c
index 917f8e9223739af853e492d97cecac0e95e0aea3..0e39f99bce8be8c38fe33dd0246012910243d831 100644
--- a/drivers/dma/stm32/stm32-dma.c
+++ b/drivers/dma/stm32/stm32-dma.c
@@ -744,7 +744,7 @@ static void stm32_dma_handle_chan_done(struct stm32_dma_chan *chan, u32 scr)
 		/* cyclic while CIRC/DBM disable => post resume reconfiguration needed */
 		if (!(scr & (STM32_DMA_SCR_CIRC | STM32_DMA_SCR_DBM)))
 			stm32_dma_post_resume_reconfigure(chan);
-		else if (scr & STM32_DMA_SCR_DBM)
+		else if (scr & STM32_DMA_SCR_DBM && chan->desc->num_sgs > 2)
 			stm32_dma_configure_next_sg(chan);
 	} else {
 		chan->busy = false;

---
base-commit: de266931dd996fc2cb8ee8b5d12e39ea463e3f36
change-id: 20250605-stm32_dma_dbm_fix-3b86271d54d4

Best regards,
-- 
Amelie Delaunay <amelie.delaunay@foss.st.com>


