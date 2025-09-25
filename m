Return-Path: <dmaengine+bounces-6710-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95019B9F04A
	for <lists+dmaengine@lfdr.de>; Thu, 25 Sep 2025 13:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65CD1BC7E99
	for <lists+dmaengine@lfdr.de>; Thu, 25 Sep 2025 11:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EA52FBDF7;
	Thu, 25 Sep 2025 11:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QrgsvBkZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134802FD1A8
	for <dmaengine@vger.kernel.org>; Thu, 25 Sep 2025 11:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758801268; cv=none; b=Z+c3lV5ZIg6FNrRqLQF8qjx2wZ7Q3Q3XCm/NgM6pl864VasJj1fgLjD3LJQL35Bt9sXTg5i5stviJS9jA0JLYuF/hvr2rvALwoVXN2vySaTUA6PIh6lJno0GRT3MigsSiz0JR1vrblP8B9MqcFfr9hrwUggPePWuGBbGwhhyI1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758801268; c=relaxed/simple;
	bh=9jsK4VDmm7LJ+YLkeBDIcPI7vSmCmKyAZvCHjfEz/yY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SEvtx8xf1TaABo1AJ0hgCnJIVwOQUU+ZXDUOB0nfrC828X4KI7rWCrpaB1DdYfhmpRaMfnKP522wRX803SvycgJhNySqf+I1vzTCuz+VFlNtGEMhg+YGWt0k7IMTDvrELGX+wsXS104wZTpGeCVtTCTHGFsd3XGcyFaft0cmcMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QrgsvBkZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PAdc6d029706
	for <dmaengine@vger.kernel.org>; Thu, 25 Sep 2025 11:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=IcQRAOQdZqK
	M5AAtXRvgWEwEH/H9DHPEDvxp2DSgWr0=; b=QrgsvBkZkXweqgEzKz8xzjo9lgS
	I4Cghic1LlrUsLqMIP8m7p7zPQ3MgN9s/WliDzuNgDOEZ0pj3ViDdMBXWMQK3dwL
	FnVBHQ6qBhtw6K5ygFitmI0ljz72D1FGORKkrTLXRQsct7Nj11u8Ki/Y95SD6Xnt
	1tAuSqs9DqteamJvRCwJnzX1H0LVFGeJ85CGlKfiAPKrdsLTXl0V7kWPKfnKHP+v
	DP2BIR76fE1UUGpnFXhlYtdc6m1tsXXFbOkwd2fofWXsUXvf5e2yrWqFPK4b8W17
	zXnvnOcS9lqOM+G0pcBtMSoINzruztAWlcyIbAyChKAlvR/98V5pBtAV4xA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fqu9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 25 Sep 2025 11:54:26 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b554fdd710bso612951a12.3
        for <dmaengine@vger.kernel.org>; Thu, 25 Sep 2025 04:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758801265; x=1759406065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcQRAOQdZqKM5AAtXRvgWEwEH/H9DHPEDvxp2DSgWr0=;
        b=sxg9Dg/M1aBgf+DldsMgIusdEURA1kh2MWPcG/YRE6fMip7IvspWjOXHIkeswu4tvY
         1xQvA9zq2cbkJbsAEmJJJ3OSY8j1oIJpBmVKxOfRcoZQKdGqeJokl/x5cyJt6IEAbcb6
         Gf+qpCMFZHCk/4PDmXPrct6RVsCG46I+CceaUkGwSkXNnMQjDFlXcvl+5OHzmIo7Asny
         rWiqoZhs8KAivJSDOvI1g/K3ez14U4VpL/Oqcmfrw9bWSyDV/9l9e+lVwlO/T83V7yGK
         dkZMhU82zTPjK3JqZRuz/aJ+lI7jQes01j5HE1rdnD9xbhb1nWMfgLk76yaR6NyU96Xd
         CmgA==
X-Forwarded-Encrypted: i=1; AJvYcCVTlkfYtJE6aLX5WlaLjVGTiZZf75e2b3/L71XDVaZUdrJ7T+KfuBwMmTZg1UcLgNYGOpF2wkZupMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN4WzodLu32Y4/WGYV3f0eTXicv+y26OpNeRvjzooewcbpJEAN
	Hi5F7d1yfRvzD9sUgBX9NUc/rBQPYETvPmCATdnsMm05S23hw0A8EOpMcU2ZdAHIVm5mCf4sHJ2
	yHyn2edFXlOd4mcLaAsGNUU0SAiuNF5GFl6AslWOIlFLdUFblYZUzpdMT6P5UEkY=
X-Gm-Gg: ASbGncuCAmMKD6jUwIcoBwJodEENoZb9VH2QF3jMQovD5unfw77KP2H2ulXJcPiG//9
	Bj26JA7/Pqn0mdJ6gpSeiQ6W4NHXYd7TwA7hpWLgT5A0sV3jGVX65n49WsxHWU0KiONaH3kao7z
	coi9pkrXN9nxzVRybuxcpQNWUv6/3oHfsGCSMeEDyPU2UIuD0l2ANoTH2jjVqH5jLyo9mZU936e
	hksrnX1oclCIYoJ44Ta17OtaY8+JF0V2vHdzk2xa3FY+36RSfdHntIQyxetLrAwodZS9YDtakG3
	f/fx2vLnf2a11N1pSXATmGdZpwp0PzJuqyFsUdBz7s17+eQXEUO6EhQKseujIiEy1OBwIC9Javc
	=
X-Received: by 2002:a17:903:3884:b0:274:3e52:4d2d with SMTP id d9443c01a7336-27ed4a76e00mr32337975ad.37.1758801265286;
        Thu, 25 Sep 2025 04:54:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9ckvMkGt+IFhS7y1WdXrjnERoOor8+C8TXNTMEGz1eO6XtWc6VahcrWBEIiWDA6gEc4+jIw==
X-Received: by 2002:a17:903:3884:b0:274:3e52:4d2d with SMTP id d9443c01a7336-27ed4a76e00mr32337705ad.37.1758801264692;
        Thu, 25 Sep 2025 04:54:24 -0700 (PDT)
Received: from hu-jseerapu-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69bb502sm22087935ad.118.2025.09.25.04.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 04:54:24 -0700 (PDT)
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>,
        Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, quic_vtanuku@quicinc.com
Subject: [PATCH v7 RESEND 1/2] dmaengine: qcom: gpi: Add GPI Block event interrupt support
Date: Thu, 25 Sep 2025 17:24:11 +0530
Message-Id: <20250925115412.2843659-2-jyothi.seerapu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925115412.2843659-1-jyothi.seerapu@oss.qualcomm.com>
References: <20250925115412.2843659-1-jyothi.seerapu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iSKXAW0-b6NzfUI3NG9S67LTy3qiNGpi
X-Proofpoint-GUID: iSKXAW0-b6NzfUI3NG9S67LTy3qiNGpi
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d52d72 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=hwQltXbWhlPaccoBuB4A:9
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX+VAGoNPIt85S
 T/zEM2yJxG4lVE0DFoUg5b8zofEmE/qvestT3UNo7k2Fjn0GuLSQYTRkBBBj17POkmbf81eHmir
 jYKd6qlfP9AcbyNY7zAbRqdPz4vs1tVA0+Tm8DnoUtppoS210FfS/CAXnNHOvPLDIrQSuORv2zS
 Gc+qI/Pu/PYzCxKCIbw39X9nSOEmt9zpaV5YCuku/dZJ/Vz2s7HU3MyDRhvGu2qSTEGmb9k7UAz
 AwQLzriIrk+5PHpCrki6P4nu6m/CbeK6he6Q5IZx5ULoJqqQERx938kx1ETe3npujZlKehifiem
 UNkPIah9wbzIEIEPshiaE435dgnrji+Wbzrndp3+rYaYkzBhqmef8jous1/z3ek3FMLnZF1kyeY
 2FUroGg6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

From: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>

GSI hardware generates an interrupt for each transfer completion.
For multiple messages within a single transfer, this results in
N interrupts for N messages, leading to significant software
interrupt latency.

To mitigate this latency, utilize Block Event Interrupt (BEI) mechanism.
Enabling BEI instructs the GSI hardware to prevent interrupt generation
and BEI is disabled when an interrupt is necessary.

Large I2C transfer can be divided into chunks of messages internally.
Interrupts are not expected for the messages for which BEI bit set,
only the last message triggers an interrupt, indicating the completion of
N messages. This BEI mechanism enhances overall transfer efficiency.

Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
---

v7 -> v8:
   - Removed duplicate sentence in commit description

v6 -> v7:
   - The design has been modified to configure BEI for interrupt
     generation either:
     After the last I2C message, if sufficient TREs are available, or
     After a specific I2C message, when no further TREs are available.
   - In the GPI driver, passed the flags argumnetr to the gpi_create_i2c_tre function
     and so avoided using external variables for DMA_PREP_INTERRUPT status.

v5 ->v6:
  - For updating the block event interrupt bit, instead of relying on
    bei_flag, decision check is moved with DMA_PREP_INTERRUPT flag.

v4 -> v5:
  - BEI flag naming changed from flags to bei_flag.
  - QCOM_GPI_BLOCK_EVENT_IRQ macro is removed from qcom-gpi-dma.h
    file, and Block event interrupt support is checked with bei_flag.

v3 -> v4:
  - API's added for Block event interrupt with multi descriptor support for
    I2C is moved from qcom-gpi-dma.h file to I2C geni qcom driver file.
  - gpi_multi_xfer_timeout_handler function is moved from GPI driver to
    I2C driver.

v2-> v3:
   - Renamed gpi_multi_desc_process to gpi_multi_xfer_timeout_handler
   - MIN_NUM_OF_MSGS_MULTI_DESC changed from 4 to 2
   - Added documentation for newly added changes in "qcom-gpi-dma.h" file
   - Updated commit description.

v1 -> v2:
   - Changed dma_addr type from array of pointers to array.
   - To support BEI functionality with the TRE size of 64 defined in GPI driver,
     updated QCOM_GPI_MAX_NUM_MSGS to 16 and NUM_MSGS_PER_IRQ to 4.

 drivers/dma/qcom/gpi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 8e87738086b2..66bfea1f156d 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -1619,7 +1619,8 @@ gpi_peripheral_config(struct dma_chan *chan, struct dma_slave_config *config)
 }
 
 static int gpi_create_i2c_tre(struct gchan *chan, struct gpi_desc *desc,
-			      struct scatterlist *sgl, enum dma_transfer_direction direction)
+			      struct scatterlist *sgl, enum dma_transfer_direction direction,
+			      unsigned long flags)
 {
 	struct gpi_i2c_config *i2c = chan->config;
 	struct device *dev = chan->gpii->gpi_dev->dev;
@@ -1684,6 +1685,9 @@ static int gpi_create_i2c_tre(struct gchan *chan, struct gpi_desc *desc,
 
 		tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
 		tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOT);
+
+		if (!(flags & DMA_PREP_INTERRUPT))
+			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_BEI);
 	}
 
 	for (i = 0; i < tre_idx; i++)
@@ -1827,6 +1831,9 @@ gpi_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		return NULL;
 	}
 
+	if (!(flags & DMA_PREP_INTERRUPT) && (nr - nr_tre < 2))
+		return NULL;
+
 	gpi_desc = kzalloc(sizeof(*gpi_desc), GFP_NOWAIT);
 	if (!gpi_desc)
 		return NULL;
@@ -1835,7 +1842,7 @@ gpi_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	if (gchan->protocol == QCOM_GPI_SPI) {
 		i = gpi_create_spi_tre(gchan, gpi_desc, sgl, direction);
 	} else if (gchan->protocol == QCOM_GPI_I2C) {
-		i = gpi_create_i2c_tre(gchan, gpi_desc, sgl, direction);
+		i = gpi_create_i2c_tre(gchan, gpi_desc, sgl, direction, flags);
 	} else {
 		dev_err(dev, "invalid peripheral: %d\n", gchan->protocol);
 		kfree(gpi_desc);
-- 
2.34.1


