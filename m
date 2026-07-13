Return-Path: <dmaengine+bounces-12387-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iF61L0PkVGp1ggAAu9opvQ
	(envelope-from <dmaengine+bounces-12387-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:12:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C1F74B608
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:12:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=TKwMSV98;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=DUujr7+u;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12387-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12387-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C17EC308CB00
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 13:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA06423A67;
	Mon, 13 Jul 2026 13:02:07 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CFB41734B
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:02:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947727; cv=none; b=Qa8SjIXU2HS3nyGQQ9BkUwaGk9vpAzY77406dFQAks+JY4ThCYu5YGQcxcY72B2WEoGBU2v847zMkAltTKFugt9itvH4MbDoCto0vq441+HGDAePL5FBg2ZETuDpjCaLrltqKS9s5yoNrCwNhfpJ8OYxj3M6vUBIM/66KDoRNOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947727; c=relaxed/simple;
	bh=czoxItsxxVvFFRsK/bUJo7zI9PxP/5bmJEdhhzZ9wNU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BwwjXWq2vYDCEGBhvtrGsxsWVmBeBnjaMxvH9c0eg+IVzKoSA7b+2dDtO8mhVROLSaS+fO0QrqR4ja3Zw4lMQ8MFDgqR4VIiAFXMiDKSZjYpzl0Uewwe0VOZpNo46x8by88kJVFufZ7xBMKVDbXrFJQR34PjGx7J1XbW4Io+69M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TKwMSV98; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DUujr7+u; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCDuGF1209908
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eLuzW4UoyjLIBOHVkT1M1Bap2xQlYADrM6wCNEKkohQ=; b=TKwMSV98S9Pnsx26
	KkuLfaI756DKEf7K1DTY7r6ZVk4EjqvMmE1y4JlOlD4eWyOR0e3avJ93fOj+eHNb
	4eSS0OQpeKKYUFCztUyDKx680FFfmOK1KtDpFUnMa2n1Itgu+WF5IVvrk19D+rvx
	k2ftv0WNM1S9fOy8odZoQ8no7SfZDgdfyCFkLVY58Dowjr0Clpb/R+cfIK5nAtD5
	BY/acZZKQ96GzYHEdk9FljFslVNeFGOdHkYlsihZ+ho0b0BtgJxeB3TzUvpLWgbT
	uq8l6kIxUFBiyXwOEwJOGiyD/BLmQ7A4OIDAJXtM6bbE3NJugJAjmMbPVT7AN1ow
	CYNBoA==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcw4qrtfs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:02:04 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6a374e480daso4223049eaf.1
        for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 06:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783947723; x=1784552523; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eLuzW4UoyjLIBOHVkT1M1Bap2xQlYADrM6wCNEKkohQ=;
        b=DUujr7+uvqgkN6RbtmY2tBKf6zJbzj3f5I1b+AamqWswLMWMZYuWdRXnGfGquvf4Oq
         o5h3EplRIt4f3x80WWSqfLYKwflTJQog88EaaE3L1naJ6DjPmln8VAsSh3L3RYmwpqj0
         tbArESBGjmiUXKR5yHqGUTRNtlSrblHAgDRiPN3VHAIlRfyCfsAkYAoiUGWVWrYZbf3l
         zYT251Cy99itiPRUQN1Ba+p1mWhjVpjPh/EmS9wPXKNo4qBIECe05PTSoz8ldR5bMnB8
         nPWk2+qW5OJH5ge/utkLOd1NscV0UuSBEAtjjsCGXwUR1TyBQCoT09FLvPFjKxflNuGd
         txvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783947723; x=1784552523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eLuzW4UoyjLIBOHVkT1M1Bap2xQlYADrM6wCNEKkohQ=;
        b=E8x3RZuRhGJ6vSqrzUygLqjuMRT7hm7CrxhcP6ICSXaYzME3OrhQ+GCqRC4fUP4ftg
         8yXr15BeoNbGOTe588CcIGawiuEJWv+8xJZuEcvft7lTME32YwEQd++GWbQU5ic2oAwK
         c+ytrrut8ISpKSKTwT1yvaeabxUSds2Qgx5MubWCv+xlIM6fuN+pWnJ7F4KILd92Yyqd
         +tQKHB2bWEzOS1czKNNCgxwaxmGwDjNZYD5MT4UrhG6fMwAIrWzWHL5yUjZ1O3FR4cgu
         GcvW96rkUZnBN1fOx8ZeOG3BHTQSz9RyW4qKTsOqZXIpAjVXuQ+gYlNKd+MIOqNq7Yzb
         Fr/A==
X-Gm-Message-State: AOJu0YzS9rJ31DkI1c08kpLfyD6xAnEv40odOfg4q6BO+h8nZ3LEYCGt
	dH+m7JiVDCo5W3dsV50HmOKDVTTRURmiaatp6Ph39c207JKHM4h1dtj/2RhhubN313qov7MPDA5
	JFxhR7z38uqAks/qoE3wj2v+kmsboVhO2mshWZ7/svBmURlAEr73Ek4nyvMWpwE4=
X-Gm-Gg: AfdE7ckYpvZg+FH71JckIAeJH3ukDEnQUK3fkyWDVVsFZxfnOkKTrZcLwDPvRTUOP0i
	Rs+EKmK/OY9c9h1BCWmJYLVH396JOSflEAv0S4XRgrG1Sl2VOZNopinN7xacBLkZdv3htg49NPs
	bPLx7YMX/BmPEkEIVF4Xm77ltMRXxiyqq74LU6aFQnuw+hfjrFg4rwZ9gS21aKbn7AvCURUGWIU
	GLNpEPU4uaoeNBH1vozNvmc+YTh7+oyiSO+hcn3scQOK+EcyQog8/S90IKMdjITkVS0ntCPcbyG
	pqiLZw+WvGK9mz15NB1t1G2+H6irUzXoj5u3yjvC6FvE1+27V7j4XFnrqCdguOoJPcFD/tqmLq9
	jrzX9nKKS
X-Received: by 2002:a05:6820:f00e:b0:69e:5e9b:a47d with SMTP id 006d021491bc7-6a38b887ca9mr6712889eaf.5.1783947723253;
        Mon, 13 Jul 2026 06:02:03 -0700 (PDT)
X-Received: by 2002:a05:6820:f00e:b0:69e:5e9b:a47d with SMTP id 006d021491bc7-6a38b887ca9mr6712811eaf.5.1783947722306;
        Mon, 13 Jul 2026 06:02:02 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8881:83b8:89fa:1a2a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2d97527sm306129725e9.2.2026.07.13.06.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:02:00 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:01:12 +0200
Subject: [PATCH v21 11/14] crypto: qce - Use existing devres APIs in
 devm_qce_dma_request()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-qcom-qce-cmd-descr-v21-11-bc2583e18475@oss.qualcomm.com>
References: <20260713-qcom-qce-cmd-descr-v21-0-bc2583e18475@oss.qualcomm.com>
In-Reply-To: <20260713-qcom-qce-cmd-descr-v21-0-bc2583e18475@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2502;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=9GKLcUmlCf8HlWjhhByBBy4VvPdK7WbPpBpBdYahW+0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqVOGfa3qCCvUSTBUNBBBq4Lg8R9jvA1p2051gH
 Jtq7nsynmiJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCalThnwAKCRAFnS7L/zaE
 w4/WD/4hgXQX2CSj/PnOZODDHnT6Q80RgU+fJzQ+FnT+fJXkgjxpy6MXvm21TuAboGFwGrZupza
 9Vk7rAIcG4P1wb96wFHFQkbF+hYoYaMldGMV3zRdObffQgZK7Z3ZUkZoAkLU8q8U8LjGnGSaR1g
 KP4n1EWkH6CMar358JbT3NP781GXxlUxl4lgqlulMJZp6b9Kt+0W4pRtZvCzlDUP06p63W3pL5C
 2XejF+uAhdaGj2IcGhvB/tPsUfmxWQZX3I2qNLdIehPMkt4tBwTaWcvQSTOPD/3IIOixtzuO4A+
 oHZAmSP0RHRWw14tqZQkjxjkbC8Vi1StCibKANBELkTRxu+xyDELWC5wDENgq+u/TAkXjEwUNxb
 pQ1TLhJM+5FRqqDB2jJXdbZz6b2/qyxUDPZgzIuKDmN9+YDX0jRdn71ai9nT2q6K4cyw0j69Iwq
 2Mt4ydFuvKnpW7l3RW5+GPTkiQNQ5Vv4l+iAuO/Z1+yJx+YGQWWFRG5q+Y5mJUPslYyn6T9n5s9
 Y29vSuDdbRCeKwOvXopztBB2TMXk3ddWjVz2nvYg7LwNw2YZSpAffYEtmo40DIutQX7o5SMNUX6
 2KRuEJuMdGW/TkJA6Hs1aOckqLpgY1UdsFZ3E9Rsx5+BIpKbr6RtQlOespje+u2xmNsRyQQR54M
 AHNiypLa8FuVBRg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEzNSBTYWx0ZWRfX/kdgnZdgSqqO
 MNj+JbvHKG1F2qpZqRRnc2er/+qNSNWOK7FzgTv7N2MrqrjkZrwixS7Aep/99Vp81GgtoTzzSW6
 VUyAZw4GB4zAH8lWYQx7gJzxHLjtZWNnv0EEHzKk34AhGJ9/uBwLZulPbZvau0qyNkyw7/KT6Sl
 jsCyHHV2v2lXciyk0zkIYxlaoKmO5VLWy+8xB683n5BKAdRwnRiR9sIaygL9tUauKHTuBk5M1C3
 xj+U1P6O1W8qdH4OT0/qIUiwHxfEdgy7Mmm3lpvh1/XXZnmT1aTWVhDOPxU6kRhafNlLsHSL/5B
 x99kdhrB44NKD15KfNQ+lpnm2EpB6blWmaRg431dVZ7y0K29y/NspC+Wji9QM9fXukX9hfXwjyJ
 yFjAAkUASB5BZaRQzAdDLVTAGJTz3tRnr+pe3bPu7r6dVzTXun206XzzDea8HfG/LxIBxkdD2vO
 +FqEIy/wQOMbpPgGQ1A==
X-Authority-Analysis: v=2.4 cv=HJrz0Itv c=1 sm=1 tr=0 ts=6a54e1cc cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=rzIBUVXPi645tD0pnwUA:9 a=QEXdDO2ut3YA:10
 a=WZGXeFmKUf7gPmL3hEjn:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: P-AkVeNFJXMcQ4wCnXWWHFXARDm96wZt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEzNSBTYWx0ZWRfX+l3Sa7rQpDVc
 Z09y0OK1NWeMddnDtRf1a4BytMLdgNUXBMqqEQp/N2446LWlT3MuZTblBb/jOLVOOweqKJLU4Mb
 Z6soOhcoJoZa526l2vXP2FUGxOG16AQ=
X-Proofpoint-ORIG-GUID: P-AkVeNFJXMcQ4wCnXWWHFXARDm96wZt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130135
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12387-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:corbet@lwn.net,m:thara.gopinath@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:quic_utiwari@quicinc.com,m:mdalam@qti.qualcomm.com,m:lumag@kernel.org,m:mani@kernel.org,m:stephan.gerhold@linaro.org,m:andersson@kernel.org,m:peter.ujfalusi@gmail.com,m:michal.simek@amd.com,m:Frank.Li@kernel.org,m:agross@codeaurora.org,m:neil.armstrong@linaro.org,m:dmaengine@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:brgl@kernel.org,m:bartosz.golaszewski@linaro.org,m:bartosz.golaszewski@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:tharagopinath@gmail.com,m:peterujfalusi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63C1F74B608

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Switch to devm_kmalloc() and devm_dma_alloc_chan() in
devm_qce_dma_request(). This allows us to drop two labels and shrink the
function.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/dma.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index d60efb5c26d88f8b0259b1dccc8724d0f75571c6..26347e9fc078adede712722107e74958538accdf 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -12,49 +12,34 @@
 
 #define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
 
-static void qce_dma_release(void *data)
+static void qce_dma_terminate(void *data)
 {
 	struct qce_dma_data *dma = data;
 
 	dmaengine_terminate_sync(dma->txchan);
 	dmaengine_terminate_sync(dma->rxchan);
-	dma_release_channel(dma->txchan);
-	dma_release_channel(dma->rxchan);
-	kfree(dma->result_buf);
 }
 
 int devm_qce_dma_request(struct qce_device *qce)
 {
 	struct qce_dma_data *dma = &qce->dma;
 	struct device *dev = qce->dev;
-	int ret;
 
-	dma->txchan = dma_request_chan(dev, "tx");
+	dma->result_buf = devm_kmalloc(dev, QCE_RESULT_BUF_SZ + QCE_IGNORE_BUF_SZ, GFP_KERNEL);
+	if (!dma->result_buf)
+		return -ENOMEM;
+
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
-
-	return devm_add_action_or_reset(dev, qce_dma_release, dma);
+	dma->rxchan = devm_dma_request_chan(dev, "rx");
+	if (IS_ERR(dma->rxchan))
+		return dev_err_probe(dev, PTR_ERR(dma->rxchan),
+				     "Failed to get RX DMA channel\n");
 
-error_nomem:
-	dma_release_channel(dma->rxchan);
-error_rx:
-	dma_release_channel(dma->txchan);
-	return ret;
+	return devm_add_action_or_reset(dev, qce_dma_terminate, dma);
 }
 
 struct scatterlist *

-- 
2.47.3


