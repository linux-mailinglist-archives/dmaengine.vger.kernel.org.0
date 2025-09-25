Return-Path: <dmaengine+bounces-6709-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 047B5B9F033
	for <lists+dmaengine@lfdr.de>; Thu, 25 Sep 2025 13:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3E54E3131
	for <lists+dmaengine@lfdr.de>; Thu, 25 Sep 2025 11:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCB42FBDF7;
	Thu, 25 Sep 2025 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k7qW1Q7/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900C32C17A0
	for <dmaengine@vger.kernel.org>; Thu, 25 Sep 2025 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758801264; cv=none; b=EuFERM3xQFCHp8Q5wDR95Xz+9p3Sd28UZTtvVwqJsvd8Hzuwu4++uf5w6UB4+HZY9iAlSc71X+ZIPcmTromDK3N5WyPUgkwlzY4+LGrG5WohnkO3jqGeAmZJWFap9RnAcw4jidbir4qvMb4ERHcAIhv/cPZO1BKZzEfzVGTj2Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758801264; c=relaxed/simple;
	bh=SyjT/o2z0dyOG2o4BytzIRC4dNs1eO2vwpK24YRaEkY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NYlxFwbGUmsmh0Dz0cNSMIwkrTrqJ/2hAiKDYeKffOTHWD/zrzuu2mtWB5NiBJfWE6gqqvNMBdh3B/OJNqmOiAHsnNH95L8Z6xhbhh6yYXFVABX/039M9FcC2SBU8K/ALELMWx8w8b/HC/6aYfI9I1PqZWqSsE5sMdnr9GkED5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k7qW1Q7/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9xfFF029565
	for <dmaengine@vger.kernel.org>; Thu, 25 Sep 2025 11:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Ibi4SnoGMV8sI9OUOF4j1A9snxHLAbs/hnY
	dDBg+Vjw=; b=k7qW1Q7/SptebFxWY3QJgijbjb8kx1guveuj61ZnjJ70SxrHSW+
	f/VugZaQ3HWw2ZT2ZS6sc4FnUoU+GuOzNJRe0M2lsvohTQObbRUjW8lI07u2F0C/
	giMUSgAWEAoaJXSP7lYSJfsS30efuoGi/87V8OuMMiwUoCAy5cB8Z4WBJo0p1TA7
	lNjK0WfXeyg3tQhDO52kp8x2pf0gXnnQyFS0UhkRQ+ajz4eLDv0ellFi7io2DmCx
	R1Uu5DVRCGHJqcH1pZFekAlEJGpJjhpq/F7rD7aFrklQOvryXADtEu0LhOuUENxu
	xf9Z6s33PlONOK7lZPF1n6gp4+zj/Zi2nfQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fqu95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 25 Sep 2025 11:54:21 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4c72281674so613688a12.3
        for <dmaengine@vger.kernel.org>; Thu, 25 Sep 2025 04:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758801261; x=1759406061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ibi4SnoGMV8sI9OUOF4j1A9snxHLAbs/hnYdDBg+Vjw=;
        b=BGh6mv95jj5edlSIiAPlCNaoVlxTKL3bgMdtGgeKhOtCbn9m6yQFfcmsvKMJ8wKdzl
         33FscEEyST7TS9KsWYvC5uUesK1/6VANcw4zaurv3fK2HtNsMHo4qfyYPk1XohQ0Hm6e
         pCXXQkIsRPP37dcr3S0KsHHyhEGEhNr4u2cKzjpQGfuoT3JDERjPSo95L3VRtSc4J6UM
         JhvHSF6n076HDMFpItjqDpC3IjnMGP4w8NotXVOVY+wpUj5XXBz+oYQQ5BdFRJGQ2msn
         X7MxcyODKsEfnhs02u2UE9ty2aQYkWAjHNH13q3Bcj5xfkyME0EhP1n029JNkbGMF0FU
         BOCg==
X-Forwarded-Encrypted: i=1; AJvYcCU3Rqn87fNfOufV9Qs/5iduMPIZxXWvWU/37Gy6kHqRfZ0yJA5Aapy1NZu6pauwXw7Ze1rfC3vHD/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuOgakTFae+DJBN7LpxnHFVjY38AsTr/6u8KgzNs3pX8/GTB85
	rmv6wOguUUadgVaYk2xzCX7B0/dHdyClJhHufrW+ARSlEWKXV2SQlmX0/n/TwO79pIJbgj4aV4Q
	X9LKU95bjdySESf6q5PD+HU5+8y/4gNtwUzQrWEKPSxYrBSFuDM+369qjp2OvWN4=
X-Gm-Gg: ASbGncuA9Nla5pXNpVdSRXlGU0MY2Wmxel2MSPxb2rlyo/yEgcfApUCQvBasvVZvanP
	0OE4BccpJsymR66NWum/3fFX8ONhMRFsx5ZHX+XH9f9Aw8JykeViN/JB3K8aPaqXJVGRbvJ2s1e
	jPI80W+DVXx4DvPO1kUqHhzwSuPa/BDocJl6yQLJzQS5+XobYkQ6HS6DHiDFvi8uYc4ljHsaZS7
	+a96LufhUocwbrrC2y22pVnjmwZuNfON+x3Esi6DJY65GrUDrb1hgPEwnSDZo3UEW57Mc9CkY+d
	YPnQ/SjKXTP6TGvTXi2g9TBxademgdejFka8R64ah+Sw3ENF1DzV5RoOZSFWXGZPnyzAma8h3cg
	=
X-Received: by 2002:a17:903:2c06:b0:269:ed31:6c50 with SMTP id d9443c01a7336-27ed4a091e8mr37880535ad.10.1758801260815;
        Thu, 25 Sep 2025 04:54:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuENIT7uqE/PhFHkktSwABTjczamPHUaUnB2zTV5WRthAd1QMusVFWwc0an+6Xwk23xxnGrw==
X-Received: by 2002:a17:903:2c06:b0:269:ed31:6c50 with SMTP id d9443c01a7336-27ed4a091e8mr37880135ad.10.1758801260297;
        Thu, 25 Sep 2025 04:54:20 -0700 (PDT)
Received: from hu-jseerapu-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69bb502sm22087935ad.118.2025.09.25.04.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 04:54:20 -0700 (PDT)
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
Subject: [PATCH v8] i2c: i2c-qcom-geni: Add Block event interrupt support
Date: Thu, 25 Sep 2025 17:24:10 +0530
Message-Id: <20250925115412.2843659-1-jyothi.seerapu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: emKE8Z3hcHPhkrdZM5bB1RUhdoSgLytZ
X-Proofpoint-GUID: emKE8Z3hcHPhkrdZM5bB1RUhdoSgLytZ
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d52d6d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=AcHsLZsjNhMhd8_3HEgA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX4hFGbHqJL5k7
 SsYspP6zl5+hljvy6ZwQtzq2dELdFItdg16dCMOtHreZAGEkcQ1AddfLavTlZQQPrPEH0jSfK9d
 arnQHhnofxyfwBB5q2fEGQd21cG2QBkm0/u1aAoOEDzwQ2VEHvNY0WzdVKIvCabCVmgMxDi12zt
 rVdIG17ABOeMLA23muH3MrQq0F5Lb3FN0mAVc7wUBfLyPABx6LDhHuPr6Rl+ieDlkGeKdD39r7Y
 Z+bXPkLfoOSgi0OQrzMzAMZHaixQPtxiRa1tp3DWD7W3LfcMQwS6jKCEzvAwqcwHpyOmj6Kfx+B
 ItTE0PdnTBE2Zw5AgQNhvIvS6UC4wlBD8k+If6UvBU30IHanta9ErJBIDekBDqsEtWqftFuZ7gp
 E3vGwxwz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

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


