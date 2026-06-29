Return-Path: <dmaengine+bounces-11852-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PG0xOxlDQmr02wkAu9opvQ
	(envelope-from <dmaengine+bounces-11852-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:04:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 167EF6D89E0
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:04:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=f1LnJ0Ml;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=cESdO7PG;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11852-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11852-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5573E302064F
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 10:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19404028D9;
	Mon, 29 Jun 2026 10:01:58 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35C9401A33
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:01:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782727318; cv=none; b=KDp8XmQ8YtdzZofMhkIPKEGuRq8sjlRqt1Rxk8H6Oyt+VIr67nm19GPa96zzOXP7J7d2+Nf71O3GJuy6oWB5s7El4D4DIOrCF7F4TNEKiNr6bm0Ng4C4tHUOVwjlL15pwZhCo3mF0ig2iYrsLiML9QGZxU3mmpCMPqPtclsdvh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782727318; c=relaxed/simple;
	bh=xewtmBe7Tjse/Oov1uLM7I+VZpNX0SB8ljw+4HhCUeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UbwoRzqYPuYOsCT/A1YXjc7Gu9A7o5cMlTUtQsSgjBHNjC8j50c5jzCzDMp2NDv81mXFxHwQMglHklfr3KDFHIG/mv0pov4za+7JGw8ZkvJ+PAnOYH4yrR8uNBikPb+J6Jti32PfapQovLANdU9H2UnUs6WlDbcQASSKY2tu4Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f1LnJ0Ml; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cESdO7PG; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T7E0ag2188890
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MsWDKH/w5P6MtO/VNux/FoMTI22L7P5oBEgCNW8qbYk=; b=f1LnJ0MluvQzqb/A
	8FGWGtZDObgYrOjIacLNIcJMDS0cd8gYOUSBrqtDae6dAJXxTAZfyDoQhE83wygQ
	4hHRphUM3dLyM+PcEMscjg0TJolFwvtYLq/6ll5RvIRkLG2HxZpPYtemCazgDl9b
	5wK38mef8N1C78X6AEa4qSBhqHl2vauAOxVW5HnmhZWaeZSfO3YEEYAY4cPIQ+SO
	miy7XOu+URqXcLu4jLutc8zmZ+aXLty67WqOPgHW6M8mqeREhuMwqwWQvYo3NNBa
	3XkWEJ+Wu1d4uD5RNaY2lwHBGpdxf3hWS/EHLkpnBPJFIFu+rQzq6AGnUJMe7611
	fOpxLw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3m4trq87-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:01:56 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-738e5b5ef68so267794137.1
        for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 03:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782727315; x=1783332115; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsWDKH/w5P6MtO/VNux/FoMTI22L7P5oBEgCNW8qbYk=;
        b=cESdO7PG2t/YZnq66+eqcsvjf0Kwa3NEtDL8YjJ347X2xD2up1RFSGGwbLGRXniOrb
         /fe06ueijplvcS1wJhCa+yqIWZ+LZ7ZpWxoQgYo9N5zryy7cw9W8RROuyTJicKhfpFQ7
         tmJS7twHUA06kr7tR/ggOIwKakIUkLWmUQtjYKju1WWARq0stDlP/4QFl+4xIJK4CikD
         MbGOLrijmMiLQrGLFhRHYARvBmRmMWPzBqSaSWkVTW15wE0A1YHgHyOYGVKttKV0WTkv
         UKTT6BjlUkPe3YIp2+IYXlGW1u9ExGo5fjweyMW/zQfwPkZ5xaNx9mOo36K75yyN480L
         zI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782727315; x=1783332115;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MsWDKH/w5P6MtO/VNux/FoMTI22L7P5oBEgCNW8qbYk=;
        b=BELdNw6LnHUVCF3Fnf8kLxxk8UMfJaimE/YVxPSA2H1fJ+HCYKwuxbxSo1AdLd6N8H
         DXz6/vi9Xcmf+AeB0Bd+cw5hRMc/l+f5rIAgvJG3CKndJNZTXrC6r6mzBbgUnNB/ELJI
         zDNXaR7PbG+JlmVUAAuO8tvQBJ6K5/uBqNxTXe5eA4v+jv34PS5PYiEvd7bCEbE+j3pb
         EjPcVyF2SVDgjsLy5z01lfXYOCR6DagIChEpVqwgmm93RDNGCBSXmjDRq28/kU6nQEe+
         psxOSJcLk6imgJF9N1Nx2zWVjbErP/2U7PJARf7wqeXASrK//a36QbeUvWETR5dcYZ/J
         0WoA==
X-Gm-Message-State: AOJu0Yxwtf+XBD6Uq/OSa6PvfLoGAnsCKUEUzTotHHUFNY5MHYdtR0P9
	H7eFdr4D4mg5lrCRKQRGedkka8ZuWoDsiZ0g7K9wZf2DGLK7CKNMBSai0Cii1HlicihnsncX5Vd
	ONZqVuad+pGkunUGA/R02uolLwGzC+o1PUzd9yvGJFlCJMF7n4cH/Kc6E+jTygXs=
X-Gm-Gg: AfdE7cleccHohGtkw4DlV8hQleooCKAKILxHdLZ25R/y/ZEByU3JW6Y2vKDC5mVLcD6
	dcx5FzIOF1+nT/ADuXhnHYUat8ckin1WNYJNZg5uwO+DDCHmi6kRC8hTzQVCNweKgxXDyhzSuQg
	T2v6GiZD+XQB36YSPGvEfsX8yIx0BUJVGce0i8pzM4SnkAwjSzVMKd4XdglhYYm1t1z96rHfDA4
	G0ZyEwbt2YiWoLMWLQBNgLe+s0Ev3FSsOZoguAmADtFHUuBNWUa7WrKeDsyH0P/tddoRARFQxDM
	KuHZMhtzEwWih6Lu9dQD/Fw0mdSaz8uzAY2XlI3Tmf9LpUGFtPZ6cUyCugJ+vd+DkMWSzkPgX91
	xFuu4lyfbUh4zRP+dZ50fABGJ10ND21qCniHnovxZ
X-Received: by 2002:a05:6102:2927:b0:738:9c30:2bab with SMTP id ada2fe7eead31-7389c30333emr1034250137.24.1782727315224;
        Mon, 29 Jun 2026 03:01:55 -0700 (PDT)
X-Received: by 2002:a05:6102:2927:b0:738:9c30:2bab with SMTP id ada2fe7eead31-7389c30333emr1034174137.24.1782727314682;
        Mon, 29 Jun 2026 03:01:54 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4705f8ea729sm24729405f8f.0.2026.06.29.03.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 03:01:53 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 12:01:16 +0200
Subject: [PATCH v20 14/14] crypto: qce - Communicate the base physical
 address to the dmaengine
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-qcom-qce-cmd-descr-v20-14-56f67da84c05@oss.qualcomm.com>
References: <20260629-qcom-qce-cmd-descr-v20-0-56f67da84c05@oss.qualcomm.com>
In-Reply-To: <20260629-qcom-qce-cmd-descr-v20-0-56f67da84c05@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1859;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=xewtmBe7Tjse/Oov1uLM7I+VZpNX0SB8ljw+4HhCUeA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQkJztJW4956nVEX9MjvwMkNGVeY7bWyWSsjEL
 JlDk0vhZGaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakJCcwAKCRAFnS7L/zaE
 w8LID/92VK6MtF4PX0Ay8O+iWvgPKwVfNgK9jA1tCP8Qd+Gh9YKfJjpq6CAhVvDnvbe18q/azgf
 hJHbJlhuPzXqYSETS56gA2/l/9+abNM9jLQKvK61ZTwUm9TXdVrWtuByl9244yf1NyP74p4C31t
 k0wv8ve08/Y1PgmWrFamnfYLHCZUgWjsB49qpNOqaM2c7kKZlpSW+K7jItm9dcdbEcGWrmF3+UA
 PABxkswczFoV5tXRN3uxgW28AEuplE8AMc8qKubRbTdYE+4SSoMdmKDkhiwOmYVTWplzJPErnuv
 9Kfl0khAZDvs+R6M4mh2Cm+PxxrbwJGxxbbvV4zqBqNo+tqE00kH4nvuMi5DUZCs3oqkXCqsDUt
 35FFBaQzYVCD9ArHQP3hIF18Pqg//htVnMFk44+/uPWoi7zLmtjzdP8qZ6F4LcuKoaVqs+iXbVS
 VsI4jCP9BSJ2yLG6O7Qwg1k6BbXv0DdrzdwCDkKmJw4Qp/8uA0QhSndqnbTl3P370E0QtvC9j1V
 MMmqD5LAZqlXgfDYnHgRmtr6Ipcq0eBPmmNPOMoJ6bgZxLCO/O0bT/TqYucw57zhs5UPUSoSiUa
 cGNQAkja49h+5Bziwx+6nJHCetoNg+WLfJospblWNsZlnZWkwPmPEzwJAVV+e5YFpI/ZyQVvqh8
 39N0QNMbtzQFong==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4MCBTYWx0ZWRfX6fL5nQ0uqgaa
 3g8iLVBEOU5DqyYk+RUcmG5GLHzP3uFXBv0IiawgrGzcXSb0otfvfpEvVOtcom45fsk+qg2J2GW
 FU4KI4Lpj3hvJeRQx3DcnT1xm6DByeO3w7M/utfQ/QLg8yvpTMD1N784z6pWRMesRj2gAjtgYN/
 gQMghE+11GNO3h2mqVEujdJ/H3vguyUx6w7A6gLzHfyqAZhRZhINYH+FymUgfPJkuEz4NC7LYgZ
 toW8v9FwFk/Y4AL5Z1QwML+sCN9LFcOMCrDHTgzHD1UXDegFRdRO4vRDRqvuJv5355WmiOn+syq
 wt/rIo53bMJW55UEoTUOi75L2eNGL11M5BfBigsVw/KbO75/KvmMJURZeQTGjRlL3aja0KjQqca
 MF1D+xIN8yAzTGCg4EY9srhFPj5JxFw2gbWUyUervgqaYnBvjIacJk4WN+Gc50ghODuizwtCnsH
 yTTEaemtojM5cxXCihA==
X-Authority-Analysis: v=2.4 cv=R58z39RX c=1 sm=1 tr=0 ts=6a424294 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=TFgmKHP77OfOvYwKDSoA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4MCBTYWx0ZWRfX2xHpptsg1X9g
 3vpj8ojlMo11s2gUedbEkYX9KAOfgmbJsOD4ygv4XEtBvvPgJ86S9BRaKjqumjoIZv4STKhuold
 Nbv2oN316ZZbL/NG8ftaJT2O24vk/PQ=
X-Proofpoint-ORIG-GUID: FhwdsvZsVNZLg7rA11qrvClpM44-0bOs
X-Proofpoint-GUID: FhwdsvZsVNZLg7rA11qrvClpM44-0bOs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290080
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11852-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:corbet@lwn.net,m:thara.gopinath@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:quic_utiwari@quicinc.com,m:mdalam@qti.qualcomm.com,m:lumag@kernel.org,m:mani@kernel.org,m:stephan.gerhold@linaro.org,m:andersson@kernel.org,m:peter.ujfalusi@gmail.com,m:michal.simek@amd.com,m:Frank.Li@kernel.org,m:agross@codeaurora.org,m:neil.armstrong@linaro.org,m:dmaengine@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:brgl@kernel.org,m:bartosz.golaszewski@linaro.org,m:bartosz.golaszewski@oss.qualcomm.com,m:tharagopinath@gmail.com,m:peterujfalusi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: 167EF6D89E0

In order to communicate to the BAM DMA engine which address should be
used as a scratchpad for dummy writes related to BAM pipe locking,
fill out and attach the provided metadata struct to the descriptor.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/dma.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 1b43c56503334154be4b8000e5a9330b2005cb64..6410f8dc5bcf517223c768a3e8f87af245076c84 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -11,6 +11,7 @@
 
 #include "core.h"
 #include "dma.h"
+#include "regs-v5.h"
 
 #define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
 #define QCE_BAM_CMD_SGL_SIZE		128
@@ -41,6 +42,10 @@ void qce_clear_bam_transaction(struct qce_device *qce)
 
 int qce_submit_cmd_desc(struct qce_device *qce)
 {
+	struct bam_desc_metadata meta = {
+		.scratchpad_addr = qce->base_phys + REG_VERSION,
+		.direction = DMA_MEM_TO_DEV,
+	};
 	struct qce_desc_info *qce_desc = qce->dma.bam_txn->desc;
 	struct qce_bam_transaction *bam_txn = qce->dma.bam_txn;
 	struct dma_async_tx_descriptor *dma_desc;
@@ -60,15 +65,21 @@ int qce_submit_cmd_desc(struct qce_device *qce)
 		goto err_unmap_sg;
 	}
 
+	ret = dmaengine_desc_attach_metadata(dma_desc, &meta, sizeof(meta));
+	if (ret)
+		goto err_free_desc;
+
 	qce_desc->dma_desc = dma_desc;
 	cookie = dmaengine_submit(qce_desc->dma_desc);
 
 	ret = dma_submit_error(cookie);
 	if (ret)
-		goto err_unmap_sg;
+		goto err_free_desc;
 
 	return 0;
 
+err_free_desc:
+	dmaengine_desc_free(dma_desc);
 err_unmap_sg:
 	dma_unmap_sg(qce->dev, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt, DMA_TO_DEVICE);
 	return ret;

-- 
2.47.3


