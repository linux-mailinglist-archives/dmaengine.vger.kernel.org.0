Return-Path: <dmaengine+bounces-10730-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCH8BvRoEGpJXAYAu9opvQ
	(envelope-from <dmaengine+bounces-10730-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 16:32:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7385B6305
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 16:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 110C330BB61C
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 13:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD645438FE6;
	Fri, 22 May 2026 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LDZnuOy9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ayvx135n"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B611D403E96
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779457222; cv=none; b=UpDjHIsLCoOxCB0zf+TWqPMSdU0BwLTMDwDGXJSKdl5VklQsJhGcJVMBZEkaj51vGIpUn4jD+9/IG9fkhSX47Jemd/0cIEjhwLKt2ZEPhrcAaslDSQ4WPMjgJYKQuv97KdQJyjSuL3czOT0Hp9w96X+6XIKC7hIPfUOYK79gW/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779457222; c=relaxed/simple;
	bh=V5TaHcay+ffQHNcEXKwi/ZBYhKP8pQ6TVeVwEy/241Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cwFHaufGDKLw023s8BxVTKA1AdYun41MfzxtqXeLTzCZF8KclR5myjwv1zqNHyYAb9QLkUpyBx/hiHZYo25MurjUP+4UHUeWU0Gt/B36G4eklPjeNJMdGT1Jj6ZU9chPVgDkyBnedTx+Kq6WdpxCVnXQrGyvf878m9hdnCjCtmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LDZnuOy9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ayvx135n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MA49443947391
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 13:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Nzx+RFwGJBLfXRvMdulLZf
	m1VO9C3GXrOju9FRXVr1U=; b=LDZnuOy9n/+Yll0n9bRE8V3N+znTyMtCnMZhv4
	xXk9FJT0Oi9grAZqHy+UDsUb8tHwa9Fj1lMUhvHa1IBt0Jxby25zAdhxY3T3zG+o
	DifXDwJgOvucx5TTxASk440BV94hCO5ftDLR6I1qYxnvZXbbsEv89A//pMt6PiGz
	BieQJXJGtRDvskp93U1gN/d3OZUlNQIhXpFMVLJgHXTkVbRaTxprq8K7BmoSe4TJ
	RAaolTiwkSuIprxuCJ+K+MqV4d6N30cnDhYS71mXyQHmxkAPxpd8hEdhdTmzrcMh
	CHdv/bIE44+wFm4GF0+V69UFVVp1yecKZqqUkPgZ9UUJ2U2A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ean2ngqb5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 13:40:18 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-516879bf1a7so195802941cf.1
        for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 06:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779457218; x=1780062018; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nzx+RFwGJBLfXRvMdulLZfm1VO9C3GXrOju9FRXVr1U=;
        b=ayvx135nrSzwkACp8I2PW56lqMpMA53WM29jENKdhUAMNPbxCOdw860nnHMDN9RnNr
         k3rkt/NRUY5BiEZM2fPGY3oNraf+Nc3dqhyanSTGdOwLrs+KIhP/E5RUXnT8ZX9wCm91
         NnA1jPKioL7WAmjjR+r5h64FfoDHfvOpov7PFTRaTCQS/Hhp6jSTtocYqKxlbP+yK0BD
         ad2DXPZcoo9+P+bVZ/lsavKJf5FdpbKms9uq3Vw90GoPeckAQ8G5nBrt8pf7XKt+zTON
         K2w6VjaJWBC2YB1mKSWmwXQb2iJ4wEiQ0ZmvMaV77QVtk41N2CwqSYNYF5PcGl7e4Ue1
         wJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779457218; x=1780062018;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nzx+RFwGJBLfXRvMdulLZfm1VO9C3GXrOju9FRXVr1U=;
        b=NHcB+HqiODAxvC0LBrFu8oFDUI5QGZpD1q23fewxB5Xce7ShnqJ3yNs63d1e1GQabr
         cm8tqS2//6M8ivLcv8pDYCM3f0QHO5mNdXyAzcOQDkg1FcEgdaCi2dDLSi+MwJvBBg53
         foIQ5fLuey5STVu/C/KrW1r6jJdGh3pEL29FVCSNNa0Xqm+GtfuMxx2PnxaV5L6P8igJ
         2AMQiDuuijGJZQeejAyAWLbefAMY5RmUMJ9bJGQ6c8watLeSN9s1ueqHtHFCnTOjFGrZ
         EjbhV3gm/UMxxRvlfPWULB6qdYgdzTUlGEWdNFSkGOK9QPhjAjD294cWwv7AtTG5SqWO
         WbTg==
X-Gm-Message-State: AOJu0YwyfpxhUYA36pTIdhoOa0jGIPrf7gZyQlD3fOvOHf+kuW5PV5vJ
	h6MV/7MDJL2/R+zDov3cEEG4qCXxMKEUUU31mcQQy9u8jBQNCa2g5nV2fxSuBrRSKAith43XTAW
	8IWrcGLCxG/oiDyTiiFh1J+NhlfaeRduRqmc5FbDDy1wGBpZ0+bU4EJdAcMO1Fm8=
X-Gm-Gg: Acq92OHdHvx008ky2nXl+8a88hdImmjYD9cXlXxH19fbJou1F3k3EXfbSs+U3fm8+uV
	k0RqvXmRQl/7Fz1p9O59TWjfVIH420/qjips1ks9Jv+qSFuA7aoh6ClnyqkoidQec6CIn7VXjlr
	gDhB7qbO8DooDvpFl0pDXxnDWzzK8sz8PBQA7A/NKjDXklaQ56KUrHrksEdz5jdaprFrcBWfTqx
	8usfJWklIeKP7GJB4iMvKKU67hkgG+guOPCuhgNvercqHr9hlFSH/xbkbXYZr63P7WpOeOPVWAO
	QNPUMTFByrRBiu1ee+ouGFLLZ9Guvwo3hp62HVJ/mjfWKwRDaOTRPoMTip1hRZ3wz0NM7pyz4hI
	bl4ukIw4O4lzBV7SO7IAQsqew4r8yXudx4vN21KL+15pL/1dCqg==
X-Received: by 2002:ac8:5f4c:0:b0:516:df09:b1ec with SMTP id d75a77b69052e-516df09b57cmr6504941cf.37.1779457217643;
        Fri, 22 May 2026 06:40:17 -0700 (PDT)
X-Received: by 2002:ac8:5f4c:0:b0:516:df09:b1ec with SMTP id d75a77b69052e-516df09b57cmr6504101cf.37.1779457217042;
        Fri, 22 May 2026 06:40:17 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:2fa:6280:a48f:fb37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454c600esm44912825e9.3.2026.05.22.06.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 06:40:16 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v18 00/14] crypto/dmaengine: qce: introduce BAM locking and
 use DMA for register I/O
Date: Fri, 22 May 2026 15:39:53 +0200
Message-Id: <20260522-qcom-qce-cmd-descr-v18-0-99103926bafc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKlcEGoC/3XSzWoDIRAA4FcJnrtBx/+e8h6lB38TIck2bru0h
 Lx7Z0NDFqoHBUf91BmvZEq1pIm8bq6kprlMZTzjgJmXDQkHd96noUQMEKAgGaN8uITxhF0awik
 OMU2hDkEm6xnLSVFLcONHTbl839W3dxwfyvQ51p/7IbNZog9OtbjZDHRIIcbggGNTu2M5uzpux
 7onizfblQGmaVg0rJNZgzdWA/wzGH0iwGwTYRSVnHUSPuvootiN07S9fLkjLj5tsfuz2MNSlFN
 oWwwtdFiW0QtDoWfBysILNC1Ai1uTuc6gUqY9i68t3bY4WtQqk7zIJoiuJVYW8LYllnzhrMsCK
 6O7+ZJPS/TyJZcKGi+5YliBqHuWWlnQeaNaLCFzZMFl70PP0k9L9v6ERktyJ60UTHhtG9btdvs
 FXoFDU1oDAAA=
X-Change-ID: 20251103-qcom-qce-cmd-descr-c5e9b11fe609
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
        Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>,
        Andy Gross <agross@codeaurora.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        brgl@kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12274;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=V5TaHcay+ffQHNcEXKwi/ZBYhKP8pQ6TVeVwEy/241Y=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqEFyuLpEoVOQZDDD6/ND3ua6YpRjQdH2B9Ni5C
 Hp+VG1b45WJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCahBcrgAKCRAFnS7L/zaE
 wxS+D/4jcLDACqrHzHF2jx7us0O7hKmuLu610y8Yt0CB8mPqScbEgy1s7Pf3RXaKwa1KSJC8HDM
 RH+2C7S8wu/Om7c5ZJgEg6XIyTNYbipjsiRbt1lScaziVd1IF3oLZPwVZ/U9CKm69m+tPMbnTJn
 eUADBXIkrdKZOw3/n4eVHnwVv5eNhz047TLNAZafdyYxiu77Cymer7ELdLlWfg2v7WdSUx2mMba
 oZagkDslKIVwm6Kx3ICc/XHB+rHfc154rWG/xDHdrb2KHE8mHYzn8ZjNVX7GNahBNjzrtxFb86z
 f3v2WpihVy1vJ66RlTDm0C/8TcResoRQeXmXFiZiUfX0knP8oVs8WsBCgpoWf+Ez4sLcdzPHQ/7
 ZYITyYGMMuxxdHy5m0TD6adAnh8tS95uMu/xi1GgRH+HlNdEvGHW9KWtrTuMMN2Z1MQs7Y3bZZj
 LdfpxAZZtJeDx+ATyP6mROYdEaTZAdZZOmtvxqxsdPO0QcZ7DoxNWOpdFThKhfLurRQzH0mgLRg
 ehRSdwfX/hNDvbzlbgRcRjDGobucNwSKiAapwskwLBjzfeIVEPnFZyTwccjmGCRXOQjpPHxk1eT
 uHV9kizst8bqIWPyVfvMFNSvutm0oeCzNIxF0yk8HrHL1osA+Zzfei0Okp2SPPk4XJia0qwU1Hb
 Ct3BgIOt+4/CWUA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=XvDK/1F9 c=1 sm=1 tr=0 ts=6a105cc3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=mYVGbHsXlysWdROdmYcA:9 a=aGUmJFkMoD6nLW8d:21 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=FO4_E8m0qiDe52t0p3_H:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: hGo-3uG837VuwldIS89H1LrmzIjv8jhI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEzNiBTYWx0ZWRfX9RDgIiAZHtk1
 npfUzjZDYKFsWey0NBzM1bb37lpkn4gZMqxrjU6JRIv6bbYDWnK6JwnCYBBc28BCMvO4XcoRWm1
 zJBM3sXTgPL3i/Q+33b79AOlCUm18cEZZlwzq2C1nEJ8DlY/rsVOojrsNyR+aH7o4cIGAxHuvaL
 3NWeP2bhbvFpXLIch/eAje8V/ccvk3FYCPeNos0MyCPdQNejvdqGsNI4T4lLgUGANtde0lkO/m+
 Ol7YbcJXSFgYCBrxmQWdmbxd8lQo/ia7nCNc7YqP1UPTCniqyvt0WBnlHXPuhfM8A7xxu3njX0S
 7fIG4duFOuToI/jalv2YUB0NfJEHIsD6H4sZuILzRUA4euMviiEqScNRcO3zn9gBvSADVNIBxzD
 IavpSYuWZ3ErffDuUXt9TBz5JyLYshrTTPfhI7N7aIjRs219WaU/rVSTaR1g7s6K6K+I0QfeNS4
 7V0ekIW/FI4Z6lhZ1/Q==
X-Proofpoint-ORIG-GUID: hGo-3uG837VuwldIS89H1LrmzIjv8jhI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220136
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10730-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1F7385B6305
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some more fixes for issues pointed out by sashiko.

Merging strategy: there are build-time dependencies between the crypto
and DMA patches so the best approach is for Vinod to create an immutable
branch with the DMA part pulled in by the crypto tree.

This iteration continues to build on top of v12 but uses the BAM's NWD
bit on data descriptors as suggested by Stephan. To that end, there are
some more changes like reversing the order of command and data
descriptors queuedy by the QCE driver.

Currently the QCE crypto driver accesses the crypto engine registers
directly via CPU. Trust Zone may perform crypto operations simultaneously
resulting in a race condition. To remedy that, let's introduce support
for BAM locking/unlocking to the driver. The BAM driver will now wrap
any existing issued descriptor chains with additional descriptors
performing the locking when the client starts the transaction
(dmaengine_issue_pending()). The client wanting to profit from locking
needs to switch to performing register I/O over DMA and communicate the
address to which to perform the dummy writes via a call to
dmaengine_desc_attach_metadata().

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

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v18:
- Free the BAM interrupt before disabling the clock in remove() path too
- convert the size assigned to command descriptors to little endian
- don't pass DMA mapping attributes to dma_map_sg() in bam_dma when
  setting up command descriptors
- Cancel the QCE workqueue *after* any outstanding DMA transfer
  completes
- When mapping the scatterlist for command descriptors: use the actual
  number of mapped segments for dmaengine_prep_slave_sg()
- Drop the leftover read_buf field from struct qce_device
- Unmap command descriptors only after terminating the RX transfer
- Pass the actual size of the metadata struct to
  dmaengine_desc_attach_metadata(), this is not really required for our
  use-case but let's do this for correctness and make sashiko happy
- Drop double assignment of bam_ce_idx in qce_clear_bam_transaction()
- Remove unused QCE_MAX_REG_READ
- Link to v17: https://patch.msgid.link/20260519-qcom-qce-cmd-descr-v17-0-53a595414b79@oss.qualcomm.com

Changes in v17:
- New patch: free the interrupt before disabling the clock in error path
  in probe()
- New patch: cancel the QCE work on device detach
- Hold the channel lock when attaching the metadata
- Reorder the operations in devm_qce_dma_request() to avoid freeing
  memory that may still be used by the DMA channel
- Register algorithms as the last step in QCE's probe() to avoid making
  the resources available to the system before the DMA is fully set up
- Fix error paths in algo request handlers
- Don't pass dmaengine attributes to map_sg_attrs() as it expects
  dma-mapping attribute flags
- Fix a dma mapping leak for command descriptors
- Rebase on top of v7.1-rc4
- Link to v16: https://patch.msgid.link/20260427-qcom-qce-cmd-descr-v16-0-945fd1cafbbc@oss.qualcomm.com

Changes in v16:
- Fix a reported race between dma_map_sg() called with spinlock taken
  and the corresponding dma_unmap_sg() called without it by moving the
  descriptor locking data into the descriptor struct
- Also queue the TX data descriptors before the command descriptors to
  match what downstream is doing
- Tweak commit messages
- Rebase on top of v7.1-rc1
- Link to v15: https://patch.msgid.link/20260402-qcom-qce-cmd-descr-v15-0-98b5361f7ed7@oss.qualcomm.com

Changes in v15:
- Extend the descriptor metadata struct to also carry the channel's
  transfer direction and stop using dmaengine_slave_config() for that
- Link to v14: https://patch.msgid.link/20260323-qcom-qce-cmd-descr-v14-0-f323af411274@oss.qualcomm.com

Changes in v14:
- Don't return an error to a client which wants to use locking on BAM
  that doesn't support it
- Add a comment describing the DMA descriptor metadata structure
- Fix memory leaks
- Remove leftovers from previous iterations
- Propagate errors from dma_cookie_assign() when setting up lock
  descriptors
- Link to v13: https://patch.msgid.link/20260317-qcom-qce-cmd-descr-v13-0-0968eb4f8c40@oss.qualcomm.com

Changes in v13:
- As part of the DMA changes in the QCE driver: reverse the order of
  queueing the descriptors in the QCE driver: queue command descriptors
  with all the register writes first, followed by all the data descriptors,
  this is in line with the recommandations from the BAM HPG
- Set the NWD (notify-when-done) bit (DMA_PREP_FENCE in dmaengine
  parlance) on the data descriptors to ensure that the UNLOCK descriptor
  will not be processed until after they have been processed by the
  engine. While technically the NWD bit is only needed on the final data
  descriptor, it's hard to tell which one *will* be the last from the
  driver's point-of-view and both the downstream driver as well as
  the Qualcomm TZ against which we want to synchronize sets NWD on every
  data descriptor,
- Revert to creating the LOCK/UNLOCK command descriptor pair in one
  place now that the NWD bit is in place,
- Link to v12: https://patch.msgid.link/20260310-qcom-qce-cmd-descr-v12-0-398f37f26ef0@oss.qualcomm.com

Changes in v12:
- Wait until the transaction is done before queueing the UNLOCK command
  descriptor
- Use descriptor metadata for communicating the scratchpad address to
  the BAM driver
- To that end: reverse the order of the series (first BAM, then QCE) to
  maintain bisectability
- Unmap buffers used for dummy writes after the transaction
- Link to v11: https://patch.msgid.link/20260302-qcom-qce-cmd-descr-v11-0-4bf1f5db4802@oss.qualcomm.com

Changes in v11:
- Use new approach, not requiring the client to be involved in locking.
- Add a patch constifying dma_descriptor_metadata_ops
- Rebase on top of v7.0-rc1
- Link to v10: https://lore.kernel.org/r/20251219-qcom-qce-cmd-descr-v10-0-ff7e4bf7dad4@oss.qualcomm.com

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
Bartosz Golaszewski (14):
      dmaengine: constify struct dma_descriptor_metadata_ops
      dmaengine: qcom: bam_dma: free interrupt before the clock in error path
      dmaengine: qcom: bam_dma: convert tasklet to a BH workqueue
      dmaengine: qcom: bam_dma: Extend the driver's device match data
      dmaengine: qcom: bam_dma: Add pipe_lock_supported flag support
      dmaengine: qcom: bam_dma: add support for BAM locking
      crypto: qce - Cancel work on device detach
      crypto: qce - Include algapi.h in the core.h header
      crypto: qce - Remove unused ignore_buf
      crypto: qce - Simplify arguments of devm_qce_dma_request()
      crypto: qce - Use existing devres APIs in devm_qce_dma_request()
      crypto: qce - Map crypto memory for DMA
      crypto: qce - Add BAM DMA support for crypto register I/O
      crypto: qce - Communicate the base physical address to the dmaengine

 drivers/crypto/qce/aead.c        |  10 +-
 drivers/crypto/qce/common.c      |  20 ++--
 drivers/crypto/qce/core.c        |  39 ++++++-
 drivers/crypto/qce/core.h        |   7 ++
 drivers/crypto/qce/dma.c         | 165 ++++++++++++++++++++++------
 drivers/crypto/qce/dma.h         |  11 +-
 drivers/crypto/qce/sha.c         |  10 +-
 drivers/crypto/qce/skcipher.c    |  10 +-
 drivers/dma/qcom/bam_dma.c       | 229 +++++++++++++++++++++++++++++++++------
 drivers/dma/ti/k3-udma.c         |   2 +-
 drivers/dma/xilinx/xilinx_dma.c  |   2 +-
 include/linux/dma/qcom_bam_dma.h |  14 +++
 include/linux/dmaengine.h        |   2 +-
 13 files changed, 422 insertions(+), 99 deletions(-)
---
base-commit: b4a253871ac29e454a62b6746b0385d52cfe7b24
change-id: 20251103-qcom-qce-cmd-descr-c5e9b11fe609

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


