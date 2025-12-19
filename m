Return-Path: <dmaengine+bounces-7822-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A6DCCF479
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 11:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 808DD30167BB
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 10:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37234301000;
	Fri, 19 Dec 2025 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SiRtDDHf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TagqGiFP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136CB2EBB98
	for <dmaengine@vger.kernel.org>; Fri, 19 Dec 2025 10:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766138912; cv=none; b=SYFVNnzMto9ANMQc0LQsDqh/sp5g4fnu0tAA1B/9CxIpr/iyR8/Dhwez4z0XeXGkTdzHtBD30ZkYBiHvAbLTSSsbWRclX4gkqRIxqDpCoKb9w2U8dVyPYsSuUiW5fKdI/3j8nd3ukHhJH9SWDmmksKve6wzVZzwTLDHBDt7NBYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766138912; c=relaxed/simple;
	bh=Moojw8zULGqZxqvHldQJMOLyqF7pHfwabUZ38Z5bdHc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ow/DYohVfSUfBcHVrEYDuMBVYbLzlxs+UXz/+DFK6xuWN4A/hSRZT4XAisE4orneB2mUPNKlTaILvdEDN5LqTNJaE/pFC7T5TpbxMDkc176Ckujqg9LiWsR2MwmnVG0OnEb75GkSGkKGnepjaoUpGn4TjUu7E7uSh2/nPHoXNAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SiRtDDHf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TagqGiFP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJ4cHBg4154669
	for <dmaengine@vger.kernel.org>; Fri, 19 Dec 2025 10:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xD2qZ5eGHejDzcQiX7ZQ98
	04UwbeJt/zT2Xf9ky8FoM=; b=SiRtDDHf2IjCn8rOrV/YgvUQb2v7layTSlXMRw
	65KFc7qWt4Pe5R6se4uz+GaOQPinShqqJBonacT+I7uDvlS0cZzuZEZ5+z4n4aTo
	nNojBR7XAI1ivljSzKprRa8n2MWB5nTtR5vT3n9/vrFYEguzrCA5161g0YGKKFsm
	NZvG3O1kCHVw0883//Dm4HdrgySdstVCvADYjNIj8nFgygDOWnESXdXTLpTBOgXm
	vDxEpCQ+WZL8AZDavgKJKEAsao2ITdwzptrLrbuwSCWAnEq8WYTvnqEsLodYJ3QQ
	oto9/ORgITxkd/rWPuhFqBwlcSXQTCjOPsCzsmXlxDauwB9g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2ct9dt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 19 Dec 2025 10:08:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4f1b39d7ed2so33736941cf.2
        for <dmaengine@vger.kernel.org>; Fri, 19 Dec 2025 02:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766138906; x=1766743706; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xD2qZ5eGHejDzcQiX7ZQ9804UwbeJt/zT2Xf9ky8FoM=;
        b=TagqGiFP6X3nCRIiknN1WPKC+n+MDvOU4MVpJWUHngx7si/lYks6k5zylZZZLYkYYx
         RSxHU9Aj9LkEhIAOWfK+LyHzR/PY3Sw/8Qa9QOOihVInOExEI3a5Ct1Kexxa5QpV751A
         Q6wFjM7S5RlzrCVMih2XfHdnEe13lt3qCEJb0lo/70cNDYKyzYJR0oLYnoJ1G5wTq8DM
         70IiWiTpUDZcEbPAf17JQE8SlB1hDtWcoRNAsJ2wpjAw+L4G7Bp0oryY7fI/60JxP8rV
         Ad6dIAPiclpSS1B2KZa4HAsae2t/lv0FVxn6xfN6gnK/d7XI538zIVx5z5NIel1CkRF5
         JX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766138906; x=1766743706;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xD2qZ5eGHejDzcQiX7ZQ9804UwbeJt/zT2Xf9ky8FoM=;
        b=UqxtTwiCRIw4/2gqbcUzN/Jk6IUkuDo+DudGVGGQi6MTeBPHlQ6qd2Im7EGwZMxD00
         xO2QokG6nnq9IWEsJlVZXyI0rcJ/BaDjqZOnAvEzwnfWUl+jduEFjSJGOMXGcns486kk
         2NrT3XpbHyD9oOsixw8NUg5rraq2z+eihiTrM5UAME3LcsnhKaI7biF2kkzRVs1m3nA2
         DFLwsBVJPXwa6KrqWYS9y0Um0+CnLbPxUNL6dCb0oLw7FQaaOKr6ASWJb46hU27w1eaE
         BOrGxhfAyKfIeqMksSzwYPMKBFnMeypeVSPvclN8NKQgdoXGdUZPpJFN6T+6NYSwKeeR
         zmrg==
X-Gm-Message-State: AOJu0YxMhjwj1c8ZOXE8fUB43Fz8Ug25/XDF/9hLku7pOGoyyTlJrRIq
	+rmPurdlBr/Bepbfp1999YukTTz9SXTlfwl7pYUXCAJqaB3t+JJU1MoLmUU2nfWnO4OEVlJvmH8
	sHES/GHdYrAQcrqE6UBUveCaRCFSuvI5PxJBHm8RC5eV2/wGF2XdHntmLB0gqbyc=
X-Gm-Gg: AY/fxX6oB62QbZYM5/fPvp4GEYbJfjXslBqfci8uBnO3QGEdtaV3xMUyRcOZUD+Wha+
	b5NYRWKPBpjRbbDA7Bk5TzxGh3FraVI+2txE6Mr0lAxvLs/nwN7aKuSa/hNuFefMbju8T3iEj+b
	wUTJ1TyPIdVvULsoEJccKxNrFNR06+9fdk5VKRVFNXs2a6hTPIKiQoXVQ4WpnbtnhUBJARnP0DS
	j5mKR01kJaYiyvE5SDPSmc6A3RTzOB5Fb32rY+xVCoc4xiHyhqRgtg8XsT92/yovKYG9lXV7Xdg
	ldkFPi3A44XKWJp+mCbUnqF0D6Dq3bjz9qtFxQNilDDWmcHp/lbgzBYya4Zm5ew42v4GsgrVItJ
	UbMsNRGiatBE3Aka7hJzz0Q6GNM8na/3IXbDxZQ==
X-Received: by 2002:a05:622a:8c4:b0:4ee:483:3123 with SMTP id d75a77b69052e-4f4abdc55e8mr30832201cf.67.1766138905944;
        Fri, 19 Dec 2025 02:08:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1lSARFgw2k7/5yVB5YJJtsVUFd7EpYxRoWeNvNaY/TnhcoAmvVi0n/bZVZf2aF1n+1jZlFw==
X-Received: by 2002:a05:622a:8c4:b0:4ee:483:3123 with SMTP id d75a77b69052e-4f4abdc55e8mr30831891cf.67.1766138905490;
        Fri, 19 Dec 2025 02:08:25 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:a48:678b:dad2:b2eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea82f6asm4209571f8f.27.2025.12.19.02.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 02:08:24 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v10 00/12] crypto/dmaengine: qce: introduce BAM locking and
 use DMA for register I/O
Date: Fri, 19 Dec 2025 11:07:39 +0100
Message-Id: <20251219-qcom-qce-cmd-descr-v10-0-ff7e4bf7dad4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOsjRWkC/23NwQrCMAwG4FcZPVtpM7a1nnwP8dC12VZwq7ZSl
 LF3NxsICjsk8P+QLzNLGD0mdipmFjH75MNEQYpDwexgph65d1QwEFBJKUr+sGGkhdyOjjtMNnJ
 boW6l7LAWmtHhPWLnX5t6uVIefHqG+N6eZLW2X67e47LigqN1zhooaerzzU8mhmOIPVu9rH8MU
 LuGJkObqmugVboB+DOWZfkAEM/sxPoAAAA=
X-Change-ID: 20251103-qcom-qce-cmd-descr-c5e9b11fe609
To: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Tiwari <quic_utiwari@quicinc.com>,
        Daniel Perez-Zoghbi <dperezzo@quicinc.com>,
        Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Michal Simek <michal.simek@amd.com>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7119;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Moojw8zULGqZxqvHldQJMOLyqF7pHfwabUZ38Z5bdHc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpRSQHGMaBv8/nJ9OZfGxnrUDaflhzLle7FqLiv
 ZGXbsfvWGyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaUUkBwAKCRAFnS7L/zaE
 w/NaD/9Zw7r7N9iwpMsE6uL5N0ucLXUSBHYWocXx91v+nn9TuIgunEieWERdx+mLOj7HwaGxMEz
 I7bR/hZclDlJz6RfdOZl2/TzXPr9BqEpBw0jYve3iUz/yzB76MehsLc4rVH2XdmTWNGeKb4nOAy
 mdkf38l20k3hvD5+J0PC2erUaRF157ZKhAFGpQXwiLxmga6S5mdlmm7HmlY/o/dyfYjM5Wqx2Yj
 GasUMkicRbMSEthSw1Fo2BeoMUPbTPxoEH0NEeIj+tQCanCoOaD0bbZx98HA4s6beZcAJZ05+ZF
 pTuOt6VnEMqGcaYPY/vWedOHVud6wu+THbeh/L5d2q9ajey85oLUPBgvndcmmtptqK00IgYY8Kl
 5qAewYZ6+McWkP3BgSB/5s0qPHTLyTc3MWuTjFwtLLNLcsirXs+PZgySE0Y8DjQf8z7aFbTg9e4
 OogTpIOjqoryt3uqjZDgT+1IbVHkxgzSA70AgIrL4Kdh6M3wTjoZo4eOOsoLI+KnuMf8KSiAwXL
 nRMft9ofaS+9YYUfIRvATiXXS+h1cOXJvoxHLt39FEOsYeqju6aWQYgJWj/CnH1T7EOTc6Pxrin
 OwsDjulRZKNBfnj3+aLCJ6b2PQs5MgEheu2D2YJk9ctAYmn7e0+ANuOsrm6nifEs7XRQsOHobuv
 NJYs1OfpJ3ov8SA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: Pjiz--rT-NGHmAoeOq9UvOHLE-nshEFm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA4MyBTYWx0ZWRfX1siw5ThQ5/b7
 ER5iSvEu8n7Om21aE4nPbYrGRES3yz3Tk/YuUTCL4z1Yxbky2VXScO2wxwsqMaGCA1JJFWrMKtc
 /f/2WaKm7ZDOblMt8fvA0BM8Uw6hTMGv5kyjjQ/8P3MckYh+ZFIB7dPcNOid8N+KzB48/Tt/3Mt
 ovaxFoUG4a9+RAJoIgZGhULU0Jz3+GnQ3s9boYxJPBYNiXxTqaGJ0rFO/MtZYP28rhodaJ4j9na
 e+wO7T59NR0+MEQQMeIRnJ8OZ6EtacnxFH6bNAP6jH48L0p+glmrel5fWgZOj9++5zPNyWoruuZ
 L5tILAXHn4s3qMuRi7ozpDDq9Zp2LoMyg0n65qzdUJy9vMuoOma25uONovgS4QNtf6Raj/I4OUS
 obPbnTRbUCMBcpVwYz0CaLOPcCDHO5oDprbHVHAQWGFSN0HvopV4bgwOmL5ynt4yn9AZsT46f/B
 E++fst79nItX10F1gzQ==
X-Proofpoint-ORIG-GUID: Pjiz--rT-NGHmAoeOq9UvOHLE-nshEFm
X-Authority-Analysis: v=2.4 cv=Lp2fC3dc c=1 sm=1 tr=0 ts=6945241b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=38Kejeklm29e0db6wA4A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190083

Vinod: I'm sending a v10 with some additional changes and a new patch
constifying the DMA descr metatada ops struct. This series has been on
the list for quite some time and has been positively reviewed by
a couple people. Unless you have a concrete suggestion on how to do it
better, I'd like to ask you to consider picking up patches 1-4 into an
immutable branch provided to the crypto maintainers. I would appreciate
if this series could make v6.20.

Currently the QCE crypto driver accesses the crypto engine registers
directly via CPU. Trust Zone may perform crypto operations simultaneously
resulting in a race condition. To remedy that, let's introduce support
for BAM locking/unlocking using DMA descriptor metadata as medium for
passing the relevant information from the QCE engine driver to the BAM
driver.

In the specific case of the BAM DMA this translates to sending command
descriptors performing dummy writes with the relevant flags set. The BAM
will then lock all other pipes not related to the current pipe group, and
keep handling the current pipe only until it sees the the unlock bit.

In order for the locking to work correctly, we also need to switch to
using DMA for all register I/O.

On top of this, the series contains some additional tweaks and
refactoring.

The goal of this is not to improve the performance but to prepare the
driver for supporting decryption into secure buffers in the future.

Tested with tcrypt.ko, kcapi and cryptsetup.

Shout out to Daniel and Udit from Qualcomm for helping me out with some
DMA issues we encountered.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v10:
- Move DESC_FLAG_(UN)LOCK BIT definitions from patch 2 to 3
- Add a patch constifying the dma engine metadata as the first in the
  series
- Use the VERSION register for dummy lock/unlock writes
- Link to v9: https://lore.kernel.org/r/20251128-qcom-qce-cmd-descr-v9-0-9a5f72b89722@linaro.org

Changes in v9:
- Drop the global, generic LOCK/UNLOCK flags and instead use DMA
  descriptor metadata ops to pass BAM-specific information from the QCE
  to the DMA engine
- Link to v8: https://lore.kernel.org/r/20251106-qcom-qce-cmd-descr-v8-0-ecddca23ca26@linaro.org

Changes in v8:
- Rework the command descriptor logic and drop a lot of unneeded code
- Use the physical address for BAM command descriptor access, not the
  mapped DMA address
- Fix the problems with iommu faults on newer platforms
- Generalize the LOCK/UNLOCK flags in dmaengine and reword the docs and
  commit messages
- Make the BAM locking logic stricter in the DMA engine driver
- Add some additional minor QCE driver refactoring changes to the series
- Lots of small reworks and tweaks to rebase on current mainline and fix
  previous issues
- Link to v7: https://lore.kernel.org/all/20250311-qce-cmd-descr-v7-0-db613f5d9c9f@linaro.org/

Changes in v7:
- remove unused code: writing to multiple registers was not used in v6,
  neither were the functions for reading registers over BAM DMA-
- remove
- don't read the SW_VERSION register needlessly in the BAM driver,
  instead: encode the information on whether the IP supports BAM locking
  in device match data
- shrink code where possible with logic modifications (for instance:
  change the implementation of qce_write() instead of replacing it
  everywhere with a new symbol)
- remove duplicated error messages
- rework commit messages
- a lot of shuffling code around for easier review and a more
  streamlined series
- Link to v6: https://lore.kernel.org/all/20250115103004.3350561-1-quic_mdalam@quicinc.com/

Changes in v6:
- change "BAM" to "DMA"
- Ensured this series is compilable with the current Linux-next tip of
  the tree (TOT).

Changes in v5:
- Added DMA_PREP_LOCK and DMA_PREP_UNLOCK flag support in separate patch
- Removed DMA_PREP_LOCK & DMA_PREP_UNLOCK flag
- Added FIELD_GET and GENMASK macro to extract major and minor version

Changes in v4:
- Added feature description and test hardware
  with test command
- Fixed patch version numbering
- Dropped dt-binding patch
- Dropped device tree changes
- Added BAM_SW_VERSION register read
- Handled the error path for the api dma_map_resource()
  in probe
- updated the commit messages for batter redability
- Squash the change where qce_bam_acquire_lock() and
  qce_bam_release_lock() api got introduce to the change where
  the lock/unlock flag get introced
- changed cover letter subject heading to
  "dmaengine: qcom: bam_dma: add cmd descriptor support"
- Added the very initial post for BAM lock/unlock patch link
  as v1 to track this feature

Changes in v3:
- https://lore.kernel.org/lkml/183d4f5e-e00a-8ef6-a589-f5704bc83d4a@quicinc.com/
- Addressed all the comments from v2
- Added the dt-binding
- Fix alignment issue
- Removed type casting from qce_write_reg_dma()
  and qce_read_reg_dma()
- Removed qce_bam_txn = dma->qce_bam_txn; line from
  qce_alloc_bam_txn() api and directly returning
  dma->qce_bam_txn

Changes in v2:
- https://lore.kernel.org/lkml/20231214114239.2635325-1-quic_mdalam@quicinc.com/
- Initial set of patches for cmd descriptor support
- Add client driver to use BAM lock/unlock feature
- Added register read/write via BAM in QCE Crypto driver
  to use BAM lock/unlock feature

---
Bartosz Golaszewski (12):
      dmaengine: constify struct dma_descriptor_metadata_ops
      dmaengine: qcom: bam_dma: Extend the driver's device match data
      dmaengine: qcom: bam_dma: Add bam_pipe_lock flag support
      dmaengine: qcom: bam_dma: implement support for BAM locking
      crypto: qce - Include algapi.h in the core.h header
      crypto: qce - Remove unused ignore_buf
      crypto: qce - Simplify arguments of devm_qce_dma_request()
      crypto: qce - Use existing devres APIs in devm_qce_dma_request()
      crypto: qce - Map crypto memory for DMA
      crypto: qce - Add BAM DMA support for crypto register I/O
      crypto: qce - Add support for BAM locking
      crypto: qce - Switch to using BAM DMA for crypto I/O

 drivers/crypto/qce/aead.c        |  10 +++
 drivers/crypto/qce/common.c      |  39 ++++++---
 drivers/crypto/qce/core.c        |  28 ++++++-
 drivers/crypto/qce/core.h        |  11 +++
 drivers/crypto/qce/dma.c         | 174 +++++++++++++++++++++++++++++++++------
 drivers/crypto/qce/dma.h         |  15 +++-
 drivers/crypto/qce/sha.c         |   8 ++
 drivers/crypto/qce/skcipher.c    |   7 ++
 drivers/dma/qcom/bam_dma.c       |  92 +++++++++++++++++++--
 drivers/dma/ti/k3-udma.c         |   2 +-
 drivers/dma/xilinx/xilinx_dma.c  |   2 +-
 include/linux/dma/qcom_bam_dma.h |  12 +++
 include/linux/dmaengine.h        |   2 +-
 13 files changed, 347 insertions(+), 55 deletions(-)
---
base-commit: c138e425266a3f8fc801c82793a7084dfbc069b6
change-id: 20251103-qcom-qce-cmd-descr-c5e9b11fe609

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


