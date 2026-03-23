Return-Path: <dmaengine+bounces-9611-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOF2Lz5gwWmaSgQAu9opvQ
	(envelope-from <dmaengine+bounces-9611-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 16:46:06 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6230E2F6DE3
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 16:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1CD8317606E
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 15:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273603C8707;
	Mon, 23 Mar 2026 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zy9ijx5S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MlZ5SaLI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BB03B6C06
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279089; cv=none; b=ptw76zvdlr4CG3o4BabJgwi4eD5H5qXIL8uNwtz253b15p2OG06u/LVfG4DAwMmfbk/cgBRjolCIhFHay9ro4L3U0VOZoPZBIc5OZI3p7eFpW0PS2I8d7twFQm7nqONkkdeY0HyzkPg5XHeN78t+l6R8FGyK6S77bm6caXFRN1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279089; c=relaxed/simple;
	bh=J6JQaK92XNV2IsiAsrkn8st/ERqfkA6XUnyKQOIn/eg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P0q4Hm0mGgDhEKmE/g8BJp3FayQcFY8Z7uVQUNOCC72ceO0SSscsUH/oxWtNdAHuLxM9p6K4kNUjE+mBGkIdIKxge71xiyUna0zZ3D3JlFH6FIzivo4i+DlKEGw+pRMpWpG1Io4KalIz1+ogp5jEIgtxDAznUS9KdhBRrti8+4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zy9ijx5S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MlZ5SaLI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NFGbBf3589296
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iL0DqmcolfEx1Yxj+LLfsMTXg/CLsi8xOZKAt5M4Zk0=; b=Zy9ijx5SkXhuqYYa
	93fFQDgbrSN+XL7HwJhLvlUUlms/ebMCoUpqxFgpy9IPxUBDtR6U7lYVkyATy22J
	8dmqgBqe1RoWns8RMBvK9UXVlneacRmQ2/3OfsSTTmOSku/EEzODgLsOoTUnQkTp
	TuWQVo+J9QkwfHfexBb9iIW1EtIMeeOP4ou0b7YpAKKlvY48ADFLTBbN9D59aXKF
	O97aPmxcxjQvy+2YvC8DqI8DLUfiRZ7yc+m5Sx+wBDjGx0IGmbU7Zmbe0svOoT/z
	/jqAdhHWFSRjBV6i+1n0f/68V4ul35HmaajAzLPN7umflAF1pZ11kFsoX2YcnDyE
	E/Bbvg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d37a0g5vn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:18:07 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-94eb42456bbso2299357241.1
        for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 08:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774279086; x=1774883886; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iL0DqmcolfEx1Yxj+LLfsMTXg/CLsi8xOZKAt5M4Zk0=;
        b=MlZ5SaLI2xmFQ7XkoxM8oICB0ap1HqQ+EPWBj6V7Q+MssUg/+YgyZ3Be7fz+Mz86I/
         EtrPPxFiVqbBCzzbL0iV07CRarjF77jWHrrzjMx/ZbsT2eUfXDFmK9+yJ8MUtjUJluBX
         WVqO25mI1vRKP2N7fyv888xnpX0wVGGeGJvt1Wyupo0j8/jPdHJY8ZvbFhpdcYzfYHgH
         AywiW670ONG3EwMmzxp9c8KJtLnSCOlTv0TLMEWf/319ddl4t7jbUwc9zSPATTGdzeEe
         3tfSBP4FOLw+oY5EF5NgOMdZS7AbGQpjPtCK7S3fvHSB14vfMOFAN0Bd6HXR6z+Hy5Ot
         +rdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774279086; x=1774883886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iL0DqmcolfEx1Yxj+LLfsMTXg/CLsi8xOZKAt5M4Zk0=;
        b=iMF7940u/mXgdbXDA/wPXGJypbQFmIXjzWkbT+eu1j47KRa1uwCiq/oTi9i6s8a316
         RoE0M+CIWHFp0Ophh2u5pZM6pKnwC0dT1MG+1iYGa2VNXXRyaJkEK0+d3p3suVuawLX0
         MkZZdZRPbNYp5t5DHafD/MkTiqG+3bfcJ//noieo/RjhvDFUXFr73CdQGvNgjgWyGcSR
         00WZfu6iXKekbTH7T9H78dCznjVLoY0a0il5cHz4pffnLEK0+fMFqiWbza2bB6IQYxTC
         /t81xheK+FotUGhFcyFQ5MknXMxfkcGO4WYkvaL7j7m254ytdTFeEe9A+UPVcQVCFNcK
         6kqw==
X-Gm-Message-State: AOJu0YzM1V2b+gNP1rnwwZ0D5md+rhy3XRgRIUwhyd0+X25X4pIczGMp
	d441B+8nnU/0PTbCq4xSOyxdqrQkakkdTEcJN9xvlzX9J1EI1jX11UnM346A10Rnv3/PPMhormT
	YyvjuZAdDWkZpYkdcecp2Fqd5rwRFKYSdNCkEf15Ps88a1mSZM21hCiIT/63YCDQ=
X-Gm-Gg: ATEYQzxeaaE4tajPL5OD92KW5RyMq7C+2XLCwggbrfftAMRPvY+YZewlth3e18R8gwx
	ubnbDm4R23GSmNOIWDAX1w8IUMtTJig6tl7p8qg//54tFgKS7257TLZTe/fqz/LOjBOb8kzui1W
	q4+KfsznKSimARmYScb5X4NBp63AZQ9EExfO7PL1IPmhFW5Xqa4eO8uAoqS4Hh+fz8A5JJM7E80
	WtjpIlu9oVZ7qtv1pZCXGwH8az96OAGEhUuWtBS7dJ0w7vWTTa1SJxfEmJWgH6b+l5jxxQv3JTS
	KsUbUNFqUnGnbVf+5mygJZYs09hDqXLr0m15mXgPcJRGLXHtBhm1mJGyNEEEbk62rChhEqKhYXQ
	xCU1JxtoaUo+zwkpoZG6uaBfqDxNjT26Nyodj8f6slpmA5VUtxgrT
X-Received: by 2002:a67:e106:0:b0:5db:dd12:3d16 with SMTP id ada2fe7eead31-602aeabdd7bmr4387290137.6.1774279080890;
        Mon, 23 Mar 2026 08:18:00 -0700 (PDT)
X-Received: by 2002:a67:e106:0:b0:5db:dd12:3d16 with SMTP id ada2fe7eead31-602aeabdd7bmr4387255137.6.1774279080281;
        Mon, 23 Mar 2026 08:18:00 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:f9a0:d7e2:7eb6:79b5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bd923sm35936993f8f.12.2026.03.23.08.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 08:17:59 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 16:17:17 +0100
Subject: [PATCH v14 11/12] crypto: qce - Add BAM DMA support for crypto
 register I/O
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-qcom-qce-cmd-descr-v14-11-f323af411274@oss.qualcomm.com>
References: <20260323-qcom-qce-cmd-descr-v14-0-f323af411274@oss.qualcomm.com>
In-Reply-To: <20260323-qcom-qce-cmd-descr-v14-0-f323af411274@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Tiwari <quic_utiwari@quicinc.com>,
        Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        brgl@kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11908;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=JXlCbp8LMrKa8gZGoF4/x1EM2L/52sBlLm6zQExbX3s=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpwVmEl8nRhwpbYJqrGa1NuAxRUY0bjVtJqPllT
 YuACPC6jfeJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCacFZhAAKCRAFnS7L/zaE
 w6h2EACwCZsTtbvW86T+U5Ctp7qkNP+tWTKlRhbx9NwjbI+1BkBMslc4kj0AuBctzHy5fpQ4gkX
 pqWj2Stfrm/SSBFtUNuG8N2+BocoRePErtTyWg8ewZneCfFic3AUXwqCoQPEggy6K+ByyoMkKEI
 mtyPC/0IWGjd4IbTKd+LF9Kl7AktlInGLuZK/rREgAR9Dra8mbh+jGGLuXJs5c1pRvzPcKjxtiZ
 hO/0qZtGCfiU/olA6ZlqUyjHPO5uLC9UChCQyqdtKIra9bw5n2pwHu4MlZI/pyChnH2jTG3E0Uh
 1E7v0PVmUwHZLsco5YtCAqMI/af5yxvGQeFOZgiX+9Oj7VSV5c29xVsYe4bhbYYc0P5YLPr7sQ6
 gMRf0FXEo5m5cYQBvcCH+UiL8E9/cLFnyBKRtbollOQnn/ji3CifrSI2/FoEvXEsYtGVoK++BV3
 XgwIB8UiaVmLawmQ+IdCRyXmtml1Fa9aCnkoaeZs5eaY28abNLYPfBT5jEkIRsM8uKLBfDD74Vy
 wofhhYL4uDKADv5PeooM/UtTLeBZf85Hhpb+zQ4OsuxBpCbj3x/2ZlTJpsne5fMYei606lYbwpx
 surX7SHkfAhJC/WDtQNnU2SVAEF3Zob48uS5brNCP+p/zrVZorWvLYDC9iBYtC+iPwem2Zw/Ajd
 P11I6rjR2vNrHFw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=GIIF0+NK c=1 sm=1 tr=0 ts=69c159af cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=9HZbPfoxh1Yo69-LKtAA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExOCBTYWx0ZWRfX40QzQMJrT8Ia
 P1ccu0BVRmd4LUGg17OalQ5Y7RnZXiaTdBpecxtMIhNeRlCmEaPlCl0w9APSogemTyo/LfnObMI
 LsdGyl0aR+AipGajxNc1HHX4C0iqt8l7C/hl6IAnPySaNCckZdp64fqqkbpS4eG3y3o1ijVU0uS
 O9D6tZHkBSWi3c15Tp8SnScCk80rFavzrm+tWE8/eIz9hV0CWXKo41+kbP1M/9nFrkX5RwZ3hQ5
 fwGiHc33vCa4F/g7s9/JnKu32wnLVJRHjahvmLl0IH1TE2+8LECoqqPnpqPDFCQ1DpYQ1i/UgiU
 epbf2l3rUJnndsjL55YRtmVbaUWOUo07mz/rggRRIgXuUWuN3xrR21QKKkXqNY2RNJQuG3EYXpX
 lOh3Gxn2dKXpqMaOZy1E5MmiaD5HZZqGC+hIvEHb5Bw2EXcRoXSjlCheMSRLm4okr1Hl6o06ynh
 XZTEy+x/MXSoMD6Axtw==
X-Proofpoint-GUID: HkfqiEPbht9ywLUo8edpJN5nLaGMRxMH
X-Proofpoint-ORIG-GUID: HkfqiEPbht9ywLUo8edpJN5nLaGMRxMH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230118
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9611-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6230E2F6DE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Implement the infrastructure for performing register I/O over BAM DMA,
not CPU.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/aead.c     |   8 +--
 drivers/crypto/qce/common.c   |  20 ++++----
 drivers/crypto/qce/core.h     |   4 ++
 drivers/crypto/qce/dma.c      | 114 ++++++++++++++++++++++++++++++++++++++++--
 drivers/crypto/qce/dma.h      |   5 ++
 drivers/crypto/qce/sha.c      |   8 +--
 drivers/crypto/qce/skcipher.c |   8 +--
 7 files changed, 141 insertions(+), 26 deletions(-)

diff --git a/drivers/crypto/qce/aead.c b/drivers/crypto/qce/aead.c
index abb438d2f8888d313d134161fda97dcc9d82d6d9..0cfea1cbfb0f927e0b8bcd57c47004cbe41175a0 100644
--- a/drivers/crypto/qce/aead.c
+++ b/drivers/crypto/qce/aead.c
@@ -468,6 +468,10 @@ qce_aead_async_req_handle(struct crypto_async_request *async_req)
 			src_nents = dst_nents - 1;
 	}
 
+	ret = qce_start(async_req, tmpl->crypto_alg_type);
+	if (ret)
+		goto error_terminate;
+
 	ret = qce_dma_prep_sgs(&qce->dma, rctx->src_sg, src_nents, rctx->dst_sg, dst_nents,
 			       qce_aead_done, async_req);
 	if (ret)
@@ -475,10 +479,6 @@ qce_aead_async_req_handle(struct crypto_async_request *async_req)
 
 	qce_dma_issue_pending(&qce->dma);
 
-	ret = qce_start(async_req, tmpl->crypto_alg_type);
-	if (ret)
-		goto error_terminate;
-
 	return 0;
 
 error_terminate:
diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
index 04253a8d33409a2a51db527435d09ae85a7880af..b2b0e751a06517ac06e7a468599bd18666210e0c 100644
--- a/drivers/crypto/qce/common.c
+++ b/drivers/crypto/qce/common.c
@@ -25,7 +25,7 @@ static inline u32 qce_read(struct qce_device *qce, u32 offset)
 
 static inline void qce_write(struct qce_device *qce, u32 offset, u32 val)
 {
-	writel(val, qce->base + offset);
+	qce_write_dma(qce, offset, val);
 }
 
 static inline void qce_write_array(struct qce_device *qce, u32 offset,
@@ -82,6 +82,8 @@ static void qce_setup_config(struct qce_device *qce)
 {
 	u32 config;
 
+	qce_clear_bam_transaction(qce);
+
 	/* get big endianness */
 	config = qce_config_reg(qce, 0);
 
@@ -90,12 +92,14 @@ static void qce_setup_config(struct qce_device *qce)
 	qce_write(qce, REG_CONFIG, config);
 }
 
-static inline void qce_crypto_go(struct qce_device *qce, bool result_dump)
+static inline int qce_crypto_go(struct qce_device *qce, bool result_dump)
 {
 	if (result_dump)
 		qce_write(qce, REG_GOPROC, BIT(GO_SHIFT) | BIT(RESULTS_DUMP_SHIFT));
 	else
 		qce_write(qce, REG_GOPROC, BIT(GO_SHIFT));
+
+	return qce_submit_cmd_desc(qce);
 }
 
 #if defined(CONFIG_CRYPTO_DEV_QCE_SHA) || defined(CONFIG_CRYPTO_DEV_QCE_AEAD)
@@ -223,9 +227,7 @@ static int qce_setup_regs_ahash(struct crypto_async_request *async_req)
 	config = qce_config_reg(qce, 1);
 	qce_write(qce, REG_CONFIG, config);
 
-	qce_crypto_go(qce, true);
-
-	return 0;
+	return qce_crypto_go(qce, true);
 }
 #endif
 
@@ -386,9 +388,7 @@ static int qce_setup_regs_skcipher(struct crypto_async_request *async_req)
 	config = qce_config_reg(qce, 1);
 	qce_write(qce, REG_CONFIG, config);
 
-	qce_crypto_go(qce, true);
-
-	return 0;
+	return qce_crypto_go(qce, true);
 }
 #endif
 
@@ -535,9 +535,7 @@ static int qce_setup_regs_aead(struct crypto_async_request *async_req)
 	qce_write(qce, REG_CONFIG, config);
 
 	/* Start the process */
-	qce_crypto_go(qce, !IS_CCM(flags));
-
-	return 0;
+	return qce_crypto_go(qce, !IS_CCM(flags));
 }
 #endif
 
diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
index a80e12eac6c87e5321cce16c56a4bf5003474ef0..d238097f834e4605f3825f23d0316d4196439116 100644
--- a/drivers/crypto/qce/core.h
+++ b/drivers/crypto/qce/core.h
@@ -30,6 +30,8 @@
  * @base_dma: base DMA address
  * @base_phys: base physical address
  * @dma_size: size of memory mapped for DMA
+ * @read_buf: Buffer for DMA to write back to
+ * @read_buf_dma: Mapped address of the read buffer
  * @async_req_enqueue: invoked by every algorithm to enqueue a request
  * @async_req_done: invoked by every algorithm to finish its request
  */
@@ -49,6 +51,8 @@ struct qce_device {
 	dma_addr_t base_dma;
 	phys_addr_t base_phys;
 	size_t dma_size;
+	__le32 *read_buf;
+	dma_addr_t read_buf_dma;
 	int (*async_req_enqueue)(struct qce_device *qce,
 				 struct crypto_async_request *req);
 	void (*async_req_done)(struct qce_device *qce, int ret);
diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index a46264735bb895b6199969e83391383ccbbacc5f..5c42fc7ddf01e11a6562d272ba7c90c906e0e312 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -4,6 +4,8 @@
  */
 
 #include <linux/device.h>
+#include <linux/dma/qcom_bam_dma.h>
+#include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <crypto/scatterwalk.h>
 
@@ -11,6 +13,96 @@
 #include "dma.h"
 
 #define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
+#define QCE_BAM_CMD_SGL_SIZE		128
+#define QCE_BAM_CMD_ELEMENT_SIZE	128
+#define QCE_MAX_REG_READ		8
+
+struct qce_desc_info {
+	struct dma_async_tx_descriptor *dma_desc;
+	enum dma_data_direction dir;
+};
+
+struct qce_bam_transaction {
+	struct bam_cmd_element bam_ce[QCE_BAM_CMD_ELEMENT_SIZE];
+	struct scatterlist wr_sgl[QCE_BAM_CMD_SGL_SIZE];
+	struct qce_desc_info *desc;
+	u32 bam_ce_idx;
+	u32 pre_bam_ce_idx;
+	u32 wr_sgl_cnt;
+};
+
+void qce_clear_bam_transaction(struct qce_device *qce)
+{
+	struct qce_bam_transaction *bam_txn = qce->dma.bam_txn;
+
+	bam_txn->bam_ce_idx = 0;
+	bam_txn->wr_sgl_cnt = 0;
+	bam_txn->bam_ce_idx = 0;
+	bam_txn->pre_bam_ce_idx = 0;
+}
+
+int qce_submit_cmd_desc(struct qce_device *qce)
+{
+	struct qce_desc_info *qce_desc = qce->dma.bam_txn->desc;
+	struct qce_bam_transaction *bam_txn = qce->dma.bam_txn;
+	struct dma_async_tx_descriptor *dma_desc;
+	struct dma_chan *chan = qce->dma.rxchan;
+	unsigned long attrs = DMA_PREP_CMD;
+	dma_cookie_t cookie;
+	unsigned int mapped;
+	int ret;
+
+	mapped = dma_map_sg_attrs(qce->dev, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt,
+				  DMA_TO_DEVICE, attrs);
+	if (!mapped)
+		return -ENOMEM;
+
+	dma_desc = dmaengine_prep_slave_sg(chan, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt,
+					   DMA_MEM_TO_DEV, attrs);
+	if (!dma_desc) {
+		dma_unmap_sg(qce->dev, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt, DMA_TO_DEVICE);
+		return -ENOMEM;
+	}
+
+	qce_desc->dma_desc = dma_desc;
+	cookie = dmaengine_submit(qce_desc->dma_desc);
+
+	ret = dma_submit_error(cookie);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void qce_prep_dma_cmd_desc(struct qce_device *qce, struct qce_dma_data *dma,
+				  unsigned int addr, void *buf)
+{
+	struct qce_bam_transaction *bam_txn = dma->bam_txn;
+	struct bam_cmd_element *bam_ce_buf;
+	int bam_ce_size, cnt, idx;
+
+	idx = bam_txn->bam_ce_idx;
+	bam_ce_buf = &bam_txn->bam_ce[idx];
+	bam_prep_ce_le32(bam_ce_buf, addr, BAM_WRITE_COMMAND, *((__le32 *)buf));
+
+	bam_ce_buf = &bam_txn->bam_ce[bam_txn->pre_bam_ce_idx];
+	bam_txn->bam_ce_idx++;
+	bam_ce_size = (bam_txn->bam_ce_idx - bam_txn->pre_bam_ce_idx) * sizeof(*bam_ce_buf);
+
+	cnt = bam_txn->wr_sgl_cnt;
+
+	sg_set_buf(&bam_txn->wr_sgl[cnt], bam_ce_buf, bam_ce_size);
+
+	++bam_txn->wr_sgl_cnt;
+	bam_txn->pre_bam_ce_idx = bam_txn->bam_ce_idx;
+}
+
+void qce_write_dma(struct qce_device *qce, unsigned int offset, u32 val)
+{
+	unsigned int reg_addr = ((unsigned int)(qce->base_phys) + offset);
+
+	qce_prep_dma_cmd_desc(qce, &qce->dma, reg_addr, &val);
+}
 
 int devm_qce_dma_request(struct qce_device *qce)
 {
@@ -31,6 +123,21 @@ int devm_qce_dma_request(struct qce_device *qce)
 	if (!dma->result_buf)
 		return -ENOMEM;
 
+	dma->bam_txn = devm_kzalloc(dev, sizeof(*dma->bam_txn), GFP_KERNEL);
+	if (!dma->bam_txn)
+		return -ENOMEM;
+
+	dma->bam_txn->desc = devm_kzalloc(dev, sizeof(*dma->bam_txn->desc), GFP_KERNEL);
+	if (!dma->bam_txn->desc)
+		return -ENOMEM;
+
+	sg_init_table(dma->bam_txn->wr_sgl, QCE_BAM_CMD_SGL_SIZE);
+
+	qce->read_buf = dmam_alloc_coherent(qce->dev, QCE_MAX_REG_READ * sizeof(*qce->read_buf),
+					    &qce->read_buf_dma, GFP_KERNEL);
+	if (!qce->read_buf)
+		return -ENOMEM;
+
 	return 0;
 }
 
@@ -90,15 +197,16 @@ int qce_dma_prep_sgs(struct qce_dma_data *dma, struct scatterlist *rx_sg,
 {
 	struct dma_chan *rxchan = dma->rxchan;
 	struct dma_chan *txchan = dma->txchan;
-	unsigned long flags = DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
+	unsigned long txflags = DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
+	unsigned long rxflags = txflags | DMA_PREP_FENCE;
 	int ret;
 
-	ret = qce_dma_prep_sg(rxchan, rx_sg, rx_nents, flags, DMA_MEM_TO_DEV,
+	ret = qce_dma_prep_sg(rxchan, rx_sg, rx_nents, rxflags, DMA_MEM_TO_DEV,
 			     NULL, NULL);
 	if (ret)
 		return ret;
 
-	return qce_dma_prep_sg(txchan, tx_sg, tx_nents, flags, DMA_DEV_TO_MEM,
+	return qce_dma_prep_sg(txchan, tx_sg, tx_nents, txflags, DMA_DEV_TO_MEM,
 			       cb, cb_param);
 }
 
diff --git a/drivers/crypto/qce/dma.h b/drivers/crypto/qce/dma.h
index 483789d9fa98e79d1283de8297bf2fc2a773f3a7..f05dfa9e6b25bd60e32f45079a8bc7e6a4cf81f9 100644
--- a/drivers/crypto/qce/dma.h
+++ b/drivers/crypto/qce/dma.h
@@ -8,6 +8,7 @@
 
 #include <linux/dmaengine.h>
 
+struct qce_bam_transaction;
 struct qce_device;
 
 /* maximum data transfer block size between BAM and CE */
@@ -32,6 +33,7 @@ struct qce_dma_data {
 	struct dma_chan *txchan;
 	struct dma_chan *rxchan;
 	struct qce_result_dump *result_buf;
+	struct qce_bam_transaction *bam_txn;
 };
 
 int devm_qce_dma_request(struct qce_device *qce);
@@ -43,5 +45,8 @@ int qce_dma_terminate_all(struct qce_dma_data *dma);
 struct scatterlist *
 qce_sgtable_add(struct sg_table *sgt, struct scatterlist *sg_add,
 		unsigned int max_len);
+void qce_write_dma(struct qce_device *qce, unsigned int offset, u32 val);
+int qce_submit_cmd_desc(struct qce_device *qce);
+void qce_clear_bam_transaction(struct qce_device *qce);
 
 #endif /* _DMA_H_ */
diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
index d7b6d042fb44f4856a6b4f9c901376dd7531454d..f7e1f49b11b9344a5c45a9caddd485d3dac91046 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -108,6 +108,10 @@ static int qce_ahash_async_req_handle(struct crypto_async_request *async_req)
 		goto error_unmap_src;
 	}
 
+	ret = qce_start(async_req, tmpl->crypto_alg_type);
+	if (ret)
+		goto error_terminate;
+
 	ret = qce_dma_prep_sgs(&qce->dma, req->src, rctx->src_nents,
 			       &rctx->result_sg, 1, qce_ahash_done, async_req);
 	if (ret)
@@ -115,10 +119,6 @@ static int qce_ahash_async_req_handle(struct crypto_async_request *async_req)
 
 	qce_dma_issue_pending(&qce->dma);
 
-	ret = qce_start(async_req, tmpl->crypto_alg_type);
-	if (ret)
-		goto error_terminate;
-
 	return 0;
 
 error_terminate:
diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 872b65318233ed21e3559853f6bbdad030a1b81f..a386b407cfb1b1b8d72ff9c2d255476c6327a3c2 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -141,6 +141,10 @@ qce_skcipher_async_req_handle(struct crypto_async_request *async_req)
 		src_nents = dst_nents - 1;
 	}
 
+	ret = qce_start(async_req, tmpl->crypto_alg_type);
+	if (ret)
+		goto error_terminate;
+
 	ret = qce_dma_prep_sgs(&qce->dma, rctx->src_sg, src_nents,
 			       rctx->dst_sg, dst_nents,
 			       qce_skcipher_done, async_req);
@@ -149,10 +153,6 @@ qce_skcipher_async_req_handle(struct crypto_async_request *async_req)
 
 	qce_dma_issue_pending(&qce->dma);
 
-	ret = qce_start(async_req, tmpl->crypto_alg_type);
-	if (ret)
-		goto error_terminate;
-
 	return 0;
 
 error_terminate:

-- 
2.47.3


