Return-Path: <dmaengine+bounces-6712-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6B1B9F0ED
	for <lists+dmaengine@lfdr.de>; Thu, 25 Sep 2025 14:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0736386C59
	for <lists+dmaengine@lfdr.de>; Thu, 25 Sep 2025 12:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797C82F619A;
	Thu, 25 Sep 2025 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i9KKXRdI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84191114
	for <dmaengine@vger.kernel.org>; Thu, 25 Sep 2025 12:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758801659; cv=none; b=HPfAWDYsFZx3Hpm/BGQQXo48ncZN5ayMF8VmOHzYHkbG1VLN4zBlJwuVvmtu4i14et6xf1xtwnG1eSdjmTcPURD6jAPTyAj4pA7ZW04A2nJWdEXG6v+XzDpmidK5KV/IG1tf68x2jHhW4YfdURkNHQ1CLndCR7d/mh+BSvafE/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758801659; c=relaxed/simple;
	bh=SyjT/o2z0dyOG2o4BytzIRC4dNs1eO2vwpK24YRaEkY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZizChfzVJsaPHhvU8QMtyoUvdJU8ED73nbjCxjjrozwm3Gyn/wCDEDNhgpygQtDut0WdN63gMUeuz6hdAVSXkLfmgy3Jvw/FuYgpE844VNY2/AwdePGr34jTX+8PnklndBXZZRvfs4yCc4TcaHw+tGgMjELHFzkopvGhYmLdOhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i9KKXRdI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P948Jv022454
	for <dmaengine@vger.kernel.org>; Thu, 25 Sep 2025 12:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Ibi4SnoGMV8sI9OUOF4j1A9snxHLAbs/hnY
	dDBg+Vjw=; b=i9KKXRdI58COK8vJctc3V1u2NMDiPYXT/9aK84O7uzmmbrZW7+u
	I0HdUNw274w8+Hae2C+FWKbMlHMhFf7hrXRxNu7mzdcbUQtq7tmoxrDPcqe5iig0
	azgg2YxMyUDw3+7vrl/k0tcQac2fmgT+H0zrxKw45GAM/FKStn+CFBx2zItqmsNS
	37bbWBK0YzqCNkPXDm1CJoDT12pJOlrc6nZoA1fazHzv9wmcAlmPYkWbEA7sz9sv
	ujslBadeGgcRq9OorZZUDgVBskSJHL2YQohthCtEwEFrocnU4Ubm/EO5i7cuhHC2
	XkthclIt4srpiby65SNo7RjZwqBi5xRDg6A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49budafj1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 25 Sep 2025 12:00:56 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-269880a7bd9so10389895ad.3
        for <dmaengine@vger.kernel.org>; Thu, 25 Sep 2025 05:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758801655; x=1759406455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ibi4SnoGMV8sI9OUOF4j1A9snxHLAbs/hnYdDBg+Vjw=;
        b=MJFqa49P51mZK5Z/zngCjT8l9ytcNFLqDadjtCWYOwbYqZWZDzOifuuquh6ley/GZU
         VaUUyP7bsOooZspV/x6ko8sa8tDueUwqQ26TTA8Fmo2XmJ56UqNiSZl6W1K64iKkbiQ0
         aJ0DY55tmO4nKBR1bEhlAaN8EpIP9BQ0x4nUuOU/FI9W8M4avC3JRPeC2TQeUSpZzP5s
         k4iibzxVZfM5L4+OkI4fiWRcZm9YKaVwEadC80rN/vluUeiqmLQDeO17skI9LytXEkXT
         pumsuZviwDYylSYZczW4h8CVoBsHPAcmzgOl0pGxS+TdMEKEtepRg6yKbuU5sx+N5gzl
         veKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYFi4nWgAoC812H3AImNIj8Ym9huJX8NldPgPuaHk3JklEg9GHUfAKWEEPRjNQo8RdVNxKw5O5M+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YysASfy+OJdEJwy4aFrJRvsdYrpdfehnj1dfsPh5GXB7AqaARhq
	4FM1Ms4J78kW4iF58qQCHTSQBKEIp6Vrc3lmlrfyT3aEqpF2OKUSenh68wmXtEU8TytKsll9PlY
	uOrgTt8Bmjlj9Lz7nNFWriSRM6lcP3GQ3mhZBz1wD3b6gtlFOKyketE1Pp67aWxQ=
X-Gm-Gg: ASbGncvfgacnq+Lh8H9PwQ0iXoSxdQ2uX4gWK7kjLVULJRgSEZKCEq9LwPk8NoLTs62
	90k22KdrQmmxFM/kU7Vzlp73zxZFaRHwQPW9jSh9TiNRFW9dAC9i/eBGvQ7l713CZ1d5QWa7rCf
	aB40eGtY+I5rfabPR3xHdKx8O9CL1mslqyRPe9r8Zts8tXIHZoDfXGehMFwWtJ4K/mlR3sq5Wa0
	bqAuI6gvwRtZv7+YdkPEUmlj23jIYaNuo+dSzYiRUd9y+soQnOxGUNDDZw+iYJYT9kB8jSrIzrE
	Nt6EamgkMUoJ35JJDhbOkQzIxH6sWMZ4WUV3UJx/S2vLIDdW7WqkGjy0qJ73SFkxBlX4P4B0cn0
	=
X-Received: by 2002:a17:902:ecc3:b0:269:4759:904b with SMTP id d9443c01a7336-27ed4ade041mr36647715ad.58.1758801654949;
        Thu, 25 Sep 2025 05:00:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnXD2mZAewf9zy3BLbepfrjU+YGJ4Cp4RyCyDnMr5leVblOCnWiw4Ra971I5AdyuLPIQ+vrw==
X-Received: by 2002:a17:902:ecc3:b0:269:4759:904b with SMTP id d9443c01a7336-27ed4ade041mr36646315ad.58.1758801653319;
        Thu, 25 Sep 2025 05:00:53 -0700 (PDT)
Received: from hu-jseerapu-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69a9668sm22266585ad.112.2025.09.25.05.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 05:00:53 -0700 (PDT)
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
Subject: [PATCH v8 0/2] i2c: i2c-qcom-geni: Add Block event interrupt support
Date: Thu, 25 Sep 2025 17:30:33 +0530
Message-Id: <20250925120035.2844283-1-jyothi.seerapu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SP5ZvOke-lzjnIJyqkfromkEZLqUw1FA
X-Proofpoint-ORIG-GUID: SP5ZvOke-lzjnIJyqkfromkEZLqUw1FA
X-Authority-Analysis: v=2.4 cv=Yaq95xRf c=1 sm=1 tr=0 ts=68d52ef8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=AcHsLZsjNhMhd8_3HEgA:9
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDExMyBTYWx0ZWRfXwaTxM9YXa3vK
 HZWSjbCKIehucA8EUyhnbbzC6FNImVkT1SNzL1yJuvBIthVp/OJpi47/ryxH87h08iOUjRx/18I
 jbcFZZ+G2Azu/XskmkjQOvVYke939KnDzw189p6uvyx9Mp9BQrm+uDMUXQ56y9BImgHoaDIq67L
 V+D/bBEeh0UrTVnyrWcROw+BbnQEgdEwU3NhgW6g+Bywo52/sm1aRdSypBdCmIbYDLTCtibACTb
 PFU1i4hAleiMFK4l+OUpeWm54De9QanC2Sdoc/rPxZjeTs20fThHET1nDg0akl2hP2gXRfXiWpE
 6kXUeJhuUdsjGmxdYi2CvadsEs/sumS3eJQ7t8fMJXeArwlPmwJNcdke3pCsuQWmVgVuVeSoaWH
 pCjGOUVe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230113

From: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>

The I2C driver gets an interrupt upon transfer completion.
When handling multiple messages in a single transfer, this
results in N interrupts for N messages, leading to significant
software interrupt latency.

To mitigate this latency, utilize Block Event Interrupt (BEI)
mechanism. Enabling BEI instructs the hardware to prevent interrupt
generation and BEI is disabled when an interrupt is necessary.

Large I2C transfer can be divided into chunks of messages internally.
Interrupts are not expected for the messages for which BEI bit set,
only the last message triggers an interrupt, indicating the completion of
N messages. This BEI mechanism enhances overall transfer efficiency.

BEI optimizations are currently implemented for I2C write transfers only,
as there is no use case for multiple I2C read messages in a single transfer
at this time.

v7 -> v8:
   - Removed duplicate sentence in patch1 commit description
   - Updated with proper types when calling geni_i2c_gpi_unmap() inside
     geni_i2c_gpi_multi_desc_unmap().

v6 -> v7:
   - The design has been modified to configure BEI for interrupt
     generation either:
     After the last I2C message, if sufficient TREs are available, or
     After a specific I2C message, when no further TREs are available.
   - dma_buf and dma_addr for multi descriptor support is changed from
     static allocation to dynmic allocation.
   - In i2c_gpi_cb_result function, for multi descriptor case, instead of invoking
     complete for everry 8 messages completions, changed the logic to Invoke 'complete'
     for every I2C callback (for submitted I2C messages).
   - For I2C multi descriptor case, updated 'gi2c_gpi_xfer->dma_buf' and
     'gi2c_gpi_xfer->dma_addr' for unmappping in geni_i2c_gpi_multi_desc_unmap.
   - In the GPI driver, passed the flags argumnetr to the gpi_create_i2c_tre function and
     so avoided using external variables for DMA_PREP_INTERRUPT status.
   - Updated documentation removed for "struct geni_i2c_dev" as per the review comments.

v5 -> v6:
   - Instead of using bei_flag, moved the logic to use with DMA
     supported flags like DMA_PREP_INTERRUPT.
   - Additional parameter comments removed from geni_i2c_gpi_multi_desc_unmap
     function documentation.

v4 -> v5:
   -  BEI flag naming changed from flags to bei_flag.
   -  QCOM_GPI_BLOCK_EVENT_IRQ macro is removed from qcom-gpi-dma.h
      file, and Block event support is checked with bei_flag.
   -  Documentation added for "struct geni_i2c_dev".

v3 -> v4:
  - API's added for Block event interrupt with multi descriptor support is
    moved from qcom-gpi-dma.h file to I2C geni qcom driver file.
  - gpi_multi_xfer_timeout_handler function is moved from GPI driver to
    I2C driver.
  - geni_i2c_gpi_multi_desc_xfer structure is added as a member of
    struct geni_i2c_dev.
  - Removed the changes of making I2C driver is dependent on GPI driver.

v2 -> v3:
  - Updated commit description
  - In I2C GENI driver, for i2c_gpi_cb_result moved the logic of
    "!is_tx_multi_xfer" to else part.
  - MIN_NUM_OF_MSGS_MULTI_DESC changed from 4 to 2
  - Changes of I2C GENI driver to depend on the GPI driver moved
    to patch3.
  - Renamed gpi_multi_desc_process to gpi_multi_xfer_timeout_handler
  - Added description for newly added changes in "qcom-gpi-dma.h" file.

v1 -> v2:
  - DT changes are reverted for adding dma channel size as a new arg of
    dma-cells property.
  - DT binding change reveted for dma channel size as a new arg of
    dma-cells property.
  - In GPI driver, reverted the changes to parse the channel TRE size
    from device tree.
  - Made the changes in QCOM I2C geni driver to support the BEI
    functionality with the existing TRE size of 64.
  - Made changes in QCOM I2C geni driver as per the review comments.
  - Fixed Kernel test robot reported compiltion issues.

Jyothi Kumar Seerapu (2):
  dmaengine: qcom: gpi: Add GPI Block event interrupt support
  i2c: i2c-qcom-geni: Add Block event interrupt support

 drivers/dma/qcom/gpi.c             |  11 +-
 drivers/i2c/busses/i2c-qcom-geni.c | 248 ++++++++++++++++++++++++++---
 2 files changed, 233 insertions(+), 26 deletions(-)

-- 
2.34.1


