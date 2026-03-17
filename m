Return-Path: <dmaengine+bounces-9490-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EbhD1JfuWmrCgIAu9opvQ
	(envelope-from <dmaengine+bounces-9490-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 15:04:02 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2079C2AB61A
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 15:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D0D23035E33
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 14:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81503E3DB4;
	Tue, 17 Mar 2026 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EGz+aa29";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Iz4Bb7J9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9347F3161A6
	for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756184; cv=none; b=rJDQ4BPaq26xMbEh5Ndf2GA7lLMs8KNpXTDOQT4EsU3Rq1ajZLlCBKHeQyF+nDdZCImaOCfupaMIS+y6D+9GU0Z6osit1L9eoSQp05hnALeK+VmWJMV195eoULpP1D1Y9bNBEiHufx9xvDZyRMp7CjUt9aY4xe8syoLmHnlGJBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756184; c=relaxed/simple;
	bh=0l3gdVnkPeEhRWmaFMSjmRRcTqey535uYCWAXzuHtwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hoHIoUTxmJsJYBDI/Z2HTRqozDL0m44DoRzPtiQQce/KDcvBynXnUimkpx4gEyYgwOdXNDGS5GQz9rOgVQKm9enoEIqutI9VjEmsINkoAR/vzJJl6+kCSKGr3nAIUAzloJ7HUBwBLnD5tlyZ7/7/ByR9bv7aikYk/nUPwBnX+H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EGz+aa29; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Iz4Bb7J9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H7cfjD1533916
	for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 14:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bP+u/9sMDsi5B9HZu73nJnAW0uvD7B1160U6L0iNO8E=; b=EGz+aa29zlBil2m5
	eJtCvruY8xpVmLJNEFbZoZ/wVHvSvjr3+pp9x+bQH/t2w4oeExip9jIqnAiVnHvr
	60QaLxx0nObYr8jXe5dQXvOG/3tl7tSwvSor2oQQqVPbgmnfleRfC/Gbz1VdfCK5
	j0zZ5D9Gix7tB1WkVSLXE01bDMi/cr5JX1Zyu+qv1/Dru+Df/0lLQOvuBkoHk4do
	/azoLuQKlJ0l9ALhq20AQsIcnKLDSgFQdMQxApW73N1vo5zsMDKfrWn4xpWWx/9f
	H6PJ0xCiNRheRw/BM6bUeiVOjw4/V3MQraaC7VU+aTWXlgMHstOnNiWBCacWPvC3
	4JOhcQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxm5k4bmt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 14:03:01 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-94e9c0edfcfso8101713241.0
        for <dmaengine@vger.kernel.org>; Tue, 17 Mar 2026 07:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773756180; x=1774360980; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bP+u/9sMDsi5B9HZu73nJnAW0uvD7B1160U6L0iNO8E=;
        b=Iz4Bb7J9S8dQ9KyDHv3LINw/QPpm0CIF3Bd1PT+4ey8ciImxZf6GLWcBevUwKTJ4QR
         h0rIMPXT1KRmO/+fH/e7dmbbXkk05rz8CvEp1Jx13Rq/yJRtgEqd2IU4xDJIl2U854i+
         dk7jL5noSuFDBneXJOcMk4bY4D5sPbM8eo3q0klH/6RAhowr96ME6B3Bg13Q+aYr6H/e
         jyhOQZkOJGCz3A/PbBOwLxhJzDqWi0OExiPGQgDfE5lNkaYUu2Cs7m2hajSx30FvG/VE
         YsRVBx9rHhz/dT1QBCmx4x5FJ9EDEbRD+dQPO1ckBTCOQnZPyx1K3LfwhJ2PzYaA6Q9U
         +Ggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773756180; x=1774360980;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bP+u/9sMDsi5B9HZu73nJnAW0uvD7B1160U6L0iNO8E=;
        b=l+o3LPtgNW3NG95pGIhD74Ow1lIUDyA0rwqvJFFb+ywGrudim/lnu4LQzVwv6ZIyec
         VRLF0ir9rJmdeabQn/AciM216xmALinkPV0abvEEAzprk/PuwcXtLJT8p/AmfEITFGu3
         OO2KKgkPNwjORkT4VR9v/eVLfgfOQo6bLQBLayMeFeoPD1eQHab3k/qvm/XmUqj+kdx/
         czzKW2ceZUK/NC1z3eksIWgCur6bfndpyLutecMb/LX0tinIEjPYWgXDj/OsSIZ33q8u
         dJXRn+pp5ONY4jnEdDwfGZSdy0c3ktHOE8VQYMDItdD0GPkKw0eQCWn9Ijyk5t3+hapD
         sQaQ==
X-Gm-Message-State: AOJu0Ywmp+lUsgJRjA2ZIKCimMeaOYQFHNPWRaK97YODGlh++NZY7ohP
	Tz0GxY/55/SBZon0+jGMGA4LhFYc54MCirQm8ZojtwpYlbTy6yu3DGh4STnbtLjEPSZORpPcj/E
	W9ruHA1gmamGGWtuSb5+PMc5ZVSfBVqqa6glWGn206uWu1rElmjPR2NcDcHinL1Y=
X-Gm-Gg: ATEYQzyeqe/EBR9I72CKjAWQyJBFphnOInWcz60ml09RkarG0dgZQITqn9gvFneL7Rk
	A3EUyBhFHWkbm091OEPo+1r5/i/r7HCIcgSgvuIZPLlP+IlLPQ7MtEWttV7GyrExrqXVIGTLRKi
	XBYcSrzehrATwEpxF0pCUrll5nF2bzMH/NNotdEmyv0frb71FYIV9AG25QFljMzkBH1kf6YlRoF
	Hzuf1X0ZrYY8+qb/+TnlglSvQKjiITUHmNMTDg7KHJ7IKjDRlcUi5iDTqAn0bkLzYm8cGweZViE
	yRy80RLpzrojd1ZkMLTFus4FxIRkThP23OajXGNEtL2zYLmYCFui1OtXr2ONNAlELgP4/6O+20g
	bYxzQCFjyg3+L9BPL0E1v59+hWT2amccD4Uw/oqWpKG7Hy+lUZ6G0
X-Received: by 2002:a05:6102:3e94:b0:5ff:befc:6769 with SMTP id ada2fe7eead31-6020e501571mr7431246137.19.1773756180535;
        Tue, 17 Mar 2026 07:03:00 -0700 (PDT)
X-Received: by 2002:a05:6102:3e94:b0:5ff:befc:6769 with SMTP id ada2fe7eead31-6020e501571mr7431185137.19.1773756180060;
        Tue, 17 Mar 2026 07:03:00 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:6aa2:dd35:4d6d:8eec])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b4938854csm9359709f8f.34.2026.03.17.07.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 07:02:59 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 15:02:16 +0100
Subject: [PATCH v13 09/12] crypto: qce - Use existing devres APIs in
 devm_qce_dma_request()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-qcom-qce-cmd-descr-v13-9-0968eb4f8c40@oss.qualcomm.com>
References: <20260317-qcom-qce-cmd-descr-v13-0-0968eb4f8c40@oss.qualcomm.com>
In-Reply-To: <20260317-qcom-qce-cmd-descr-v13-0-0968eb4f8c40@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2266;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=azGHQ+ypZ4Lhe2NPlFIx77n1JCkKbs9Xx9/yXH7ccEw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpuV75a/3hqKscMttJVdIpHU0Ak2Rn1jbf9LnQu
 W95CnUaur2JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCable+QAKCRAFnS7L/zaE
 w2XtEACBewY081381qeqX5U47HXcuZKex2c6satG7MyFWMealTHUY3EW1swTfruzBAe4lrO4rP6
 93JvwRd454mu76difO54tSmpYX2kWMT3A1cKuy47ag+D52tLLRdf2FrLwjIVMnEPEMEnGppBJlV
 nqEB3a0Omz2xwXEeKi9RWFskSG0stfmIMvWg1Khgb7X0mi2WkEh8DU7r06mbS7TVH18Y5EqL5Ur
 PhYFzqd8VNdNmV41K1PBY/G3xlJiLgsq5VEC2k8qwqz7hLmLGCHgKtfl8DpLlq18G/rxSOCy0Zq
 efFms1UhJo3WBqpoXBkFuJZxpNrjL4LbSksIOrU2YTzur+p3zQgICAeUDYxkm4UKSsufe8ADPsN
 y8XW3LA1P6K4YHqGwbq2+E4QRP77TA67KSobE8MSUlnEILPcJEvxG9eT3J0sGOEzdYcuYdN9/MN
 bHlW1Z9LStS4t/bmPnRYJH8uCAZOjlU+cjCK/+XTW2P43ASegV8CqbK/kc1ja3oybX476cW+dRp
 lHm+VSbjFfRNaxzWVeFmxna/bJj+TgYOr8dmjYmU2HleCupjq8O/odr2awqucVTxpHqaRUcJdHD
 6gP9jYe1UetONfiII8OQyZhJicACUml61IKwd/gOUz8R3L0JNtv2miSDbAjfr0MfSyTTz9Nf5de
 7lCvFlvWj6eC93w==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=fJ00HJae c=1 sm=1 tr=0 ts=69b95f15 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=r78XHnC5kAO70zNBxnsA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEyNCBTYWx0ZWRfX2eCVlIsF/Q/3
 /IeXQK9T+OIuWgluuw0U+YnykbNLLxWT2dlZxpBu+h7itAA7ziQnCHxqDkmOTgQRWf/HdcnUMpW
 YCx8PLW8FfAyK+1w4zBv+3/7ydL6xepWPN5tqCX6oHwSnmuJXmBDw8/2dncCQm5Vlps/NoNylTc
 sXBWrt/YoQrCC0ycmzd4h4cIZtjVkvadNW+sk6wpPydq4dE/0l6nVNZcDnPqbRHXa++ekUrD7qE
 Ec/MQH8YkKn3SbKLGhYCTshceq7/YI6xBKlUPe7IH4TOEfPoOHflCKY59HRUXuU4h4yJKN41cVK
 eAhEj8BR4oyKsYZvgk6fGQj53QnXQAvzzaWxAUMv9+ILwpMl0/JGYWoQfKEIAtHjmRLO5+rfpSb
 3YTEwLig3NOh/2N3CzuYuBkqL2iJPnutfehszfRFWzIdtAZQluy4fYJMC7WhdqBN10C8l3pspIk
 xCnGsIqO9o1LRA9rfjw==
X-Proofpoint-GUID: 6o0QdGhsAR028lLuUw0W-535iHF05DJ7
X-Proofpoint-ORIG-GUID: 6o0QdGhsAR028lLuUw0W-535iHF05DJ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170124
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-9490-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[linaro.org:query timed out,qualcomm.com:query timed out,oss.qualcomm.com:query timed out];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[oss.qualcomm.com:query timed out,qualcomm.com:query timed out,linaro.org:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RBL_SEM_IPV6_FAIL(0.00)[2600:3c09:e001:a7::12fc:5321:query timed out];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2079C2AB61A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Switch to devm_kmalloc() and devm_dma_alloc_chan() in
devm_qce_dma_request(). This allows us to drop two labels and shrink the
function.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/dma.c | 39 +++++++++------------------------------
 1 file changed, 9 insertions(+), 30 deletions(-)

diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index c29b0abe9445381a019e0447d30acfd7319d5c1f..a46264735bb895b6199969e83391383ccbbacc5f 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -12,47 +12,26 @@
 
 #define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
 
-static void qce_dma_release(void *data)
-{
-	struct qce_dma_data *dma = data;
-
-	dma_release_channel(dma->txchan);
-	dma_release_channel(dma->rxchan);
-	kfree(dma->result_buf);
-}
-
 int devm_qce_dma_request(struct qce_device *qce)
 {
 	struct qce_dma_data *dma = &qce->dma;
 	struct device *dev = qce->dev;
-	int ret;
 
-	dma->txchan = dma_request_chan(dev, "tx");
+	dma->txchan = devm_dma_request_chan(dev, "tx");
 	if (IS_ERR(dma->txchan))
 		return dev_err_probe(dev, PTR_ERR(dma->txchan),
 				     "Failed to get TX DMA channel\n");
 
-	dma->rxchan = dma_request_chan(dev, "rx");
-	if (IS_ERR(dma->rxchan)) {
-		ret = dev_err_probe(dev, PTR_ERR(dma->rxchan),
-				    "Failed to get RX DMA channel\n");
-		goto error_rx;
-	}
-
-	dma->result_buf = kmalloc(QCE_RESULT_BUF_SZ + QCE_IGNORE_BUF_SZ,
-				  GFP_KERNEL);
-	if (!dma->result_buf) {
-		ret = -ENOMEM;
-		goto error_nomem;
-	}
+	dma->rxchan = devm_dma_request_chan(dev, "rx");
+	if (IS_ERR(dma->rxchan))
+		return dev_err_probe(dev, PTR_ERR(dma->rxchan),
+				     "Failed to get RX DMA channel\n");
 
-	return devm_add_action_or_reset(dev, qce_dma_release, dma);
+	dma->result_buf = devm_kmalloc(dev, QCE_RESULT_BUF_SZ + QCE_IGNORE_BUF_SZ, GFP_KERNEL);
+	if (!dma->result_buf)
+		return -ENOMEM;
 
-error_nomem:
-	dma_release_channel(dma->rxchan);
-error_rx:
-	dma_release_channel(dma->txchan);
-	return ret;
+	return 0;
 }
 
 struct scatterlist *

-- 
2.47.3


