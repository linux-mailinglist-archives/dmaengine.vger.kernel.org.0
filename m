Return-Path: <dmaengine+bounces-10549-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIE1BwpmDGpXggUAu9opvQ
	(envelope-from <dmaengine+bounces-10549-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:30:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB11557FB16
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A844231290E9
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 13:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A9F4028FE;
	Tue, 19 May 2026 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ajRB1AQQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A0rxGd9F"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874ED408131
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196722; cv=none; b=k3rbK6JlozA7D8wrdMjKCaMHAt8uFfCPFtjHZdvCx+AdLMzfqw5G1OOicTeGlKzBdPtQvaFGXhF515tbHB4SMOtidK+KYKUSd/wkY+lsw+URl8Hm4lWxwjy4KCkXEyed3E7fnBamj+X4g+jdopEWumIe3zurCpUsHdsruBXR3io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196722; c=relaxed/simple;
	bh=fF3LWtSaRCfQuTbybvZLaTumSZGXpdr/02UZIHBIpKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ot8dj+xT5AZBDJOqEtonLtxxM7wPFxuE8C2hSMjJtxe1gZu0K2rOHlpZJLe/RN3fy+3TgCZAWXuy33ril2zjtIT+QfYKx7XPeIxKsjRlnr01SlZOMSsptPaBMJuxzcf/ahKroxMMF7Rkf0UXnFMClK+tWzEUqCW+LDv50ezNxMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ajRB1AQQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A0rxGd9F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JC8ZKY1737098
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+izIZHqLCBp8T21B+b5LpfhK3/xi1bxBWarBUiU8z6U=; b=ajRB1AQQF9z9+lL8
	p9Hr2Gr/QH4SKqIzCfYR4ce938jL9xfYO4xeOAw5A4rBZTAQZA9lfZw3hNebV/rm
	yB6DojcCyrdasuoWGYGxe6DrEDPdVkslz5+d8KA5FMFwNFQv9XqNREDeXoQEA1ik
	3adY0X9uQsBMfFFbUy/cdHkMRNg+tSt6BONSH1lkBqE6pyqZjScB28uC5OOXBhSk
	SbDTBc/Y2RSW5K+59vhUjnurtzDD2QIEukEBt/mlHu0fqPQwOtHWg4/+T0fWtslm
	E4gkh843gELkA+L8h7YWRw5B5IsTokO2R2yBpJ8340NS3H4GiVn5h/GJl7l0WDJy
	uAGoaQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8ju91jnm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:39 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-575456ad2b2so2466970e0c.0
        for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 06:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779196719; x=1779801519; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+izIZHqLCBp8T21B+b5LpfhK3/xi1bxBWarBUiU8z6U=;
        b=A0rxGd9FtFRBLDihn3Ltp+w3/qVxTM/gVzPn/1GNyCDLqmXVlsF9odC+p1kwygGfpU
         RUtWusYl1DhnIAffN0rRbN8hN6fd32qa6y7NTjMNZb5L7UusDqJDvOKP6i9RPFWIVzg/
         VF6YUvPCJBtp6dTpuX3n/IqptYm9q7lYv9hPIM15eB/iy7HZn5mSQzRz5f/XHa7rOfAn
         Nn9sYrJ6lF6IsAM3B8DE3ekeOBrvqu9BN1JY/S5dCa+OMIiUM+UwtUqemdDPP4N6GVOC
         ck2TZn0RyOzhUrmG+pzAO8Jn3IpYPlgWXK8F31lbacwY33EIvSUvHlv//OiNRpfc5qkZ
         ygvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779196719; x=1779801519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+izIZHqLCBp8T21B+b5LpfhK3/xi1bxBWarBUiU8z6U=;
        b=MQm65cB7I7k9Ox7PC2ScxN+7F1CYxKKeXzjgXs/8hOIiStUmr+awXi+AuFXDCFcred
         4sd8l4NIGacW281Xadu7Hbaoud4tcIbsAbtfC8Xr72vAsJ123a2gkDSlHw1wrzQJXT3a
         c92bsI6kJJXIQZ7lOvS5FnEISDs7CGGkWXEZc0bCi/wN8bbH4qCTdHaIADcyFoKH+3AH
         MLM+MXg4tlCXDgiWUn/fwh6z5RJPcZ/+EV+qtES/l0Uihp4qC5s88kqqhLamf6grnz8x
         WuwawePVGA1IMv73eSvnbmP9Iy/UdR0gIgTyaJ/pCJeKxZCCgACJLVSyOJhDxma9N0z0
         wZGA==
X-Gm-Message-State: AOJu0YycIpXK8IUPgBIMm+YyH44IyBBqemO05MS1PV9VjE8b02f6rB+5
	mh6TOU3HxuAYiOCkgnwuZr9uHgF/+m0YLqsmqXhMgzM48mLO+nIBrckfSfMVULLpuFYfPT7tS8+
	FhZsG+Zrxqy/j8sbNiZ5OWFiusMNl3/wBibMlBbG861aZ890GHYdzRm/z1ZfqQy0=
X-Gm-Gg: Acq92OHb9p0bXa+kGFwvEBFwQHtgZevabepITSCyEj0l+amjx2qXGbjIMHuImo+4PwY
	xuKgWEtw1KHQmde6mspNJNbSHxNV0Ct47Bvm+DEAwiTwa+RWa2UaIeLvOoM/exa/1IZohNa+U1G
	ENBXemmmdAkzQOTzwic/Ot49eYXAtS0Y2IimjMW6J/8h/zKKLSva/9nD8SkECtidqwiCYKuS4/A
	nmt4KzEKrcqwLyIi6O8WoKfjcTzS1AwMtZ3fGMK07Ni0VIRs5rBrwrDzuCDAu7ZKLp8ZaU07LTH
	u/qpQL5F4hwDh7lQvpMoirMWu56pnDHKAemF8DKaoAlqq7igsOTHwqwooyV5rFrJUNqrs8PuToi
	WuBWT/Qu2ORyEZCN/W6Iq0HVZWg8T6A8BznOoycjK4uXf5Dp2oJeOIzCXNtlS2w==
X-Received: by 2002:a05:6122:3c4d:b0:575:a6f4:46b4 with SMTP id 71dfb90a1353d-5760c0b790bmr9222914e0c.9.1779196718690;
        Tue, 19 May 2026 06:18:38 -0700 (PDT)
X-Received: by 2002:a05:6122:3c4d:b0:575:a6f4:46b4 with SMTP id 71dfb90a1353d-5760c0b790bmr9222857e0c.9.1779196718090;
        Tue, 19 May 2026 06:18:38 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:3fb6:74e3:3c25:ba2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe7dd22sm143969195e9.7.2026.05.19.06.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:18:37 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 19 May 2026 15:17:56 +0200
Subject: [PATCH v17 14/14] crypto: qce - Communicate the base physical
 address to the dmaengine
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-qcom-qce-cmd-descr-v17-14-53a595414b79@oss.qualcomm.com>
References: <20260519-qcom-qce-cmd-descr-v17-0-53a595414b79@oss.qualcomm.com>
In-Reply-To: <20260519-qcom-qce-cmd-descr-v17-0-53a595414b79@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1550;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=fF3LWtSaRCfQuTbybvZLaTumSZGXpdr/02UZIHBIpKc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDGMN8gfVCSHQkgogvpJk/77PWD87w1mz+Yhe6
 /EA9InD0eqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCagxjDQAKCRAFnS7L/zaE
 wyD0D/9OyxpLqslfzb+VGtAo4gbAefVOklFa/B6bIa4jrZLqXy8VOVv1wK20H6XQL4MAJX0Fr8G
 mnEB7w7i2qk6i6UjU76GGGvUIYifYwmEYd/yHk1dOAOtsXCV9dJGfglGM/Y8gFyFzjgz8pm+oFo
 c9O0Zga8oVlWoA93I5DXx5Zr0+cHWozkXvvq9wAZN/jHw7YtPvBWmC385t8BfdNcq7F6OgBoAdF
 WO2+JwdY+k7rgxiyEr5AXJ0bSJVkEPiJ4/iu3Cc4+A1IQWobsPOww3udWQtLdErKUyIexiGkHZ7
 mZNl7aSV87jY+7C4iOfsmzUQYJLEYJaDGdns8urmHxyrAbJISlupVxMVHqEG86C5QcuSLpgw6zi
 cnCM6jei2hKIvXir4rbY+XwAOgFoYbtuX9/R5x2RG3tg5WHNIfRXfFaR94LbgRjqe6ANuLiU8Cj
 r6kuQmHoVkd75GHNZYmJe2Rwc/KCzrPPY2sMjOU/O39K1Ib6F20NVKL6w1ZmEH+5wnCv2JKjAJC
 zAxB9mPAGhIFAbtTVlclztYhkHNCg1i94S8v5PZBwZz9aZPALPuYLt1FVAHJtwF6kNq3VksgagG
 fbBxpIh2IntnUarvsIVtmffG4Qq+e0rRwQASh5Zw7xIlI4M3SWtVjAbG1IICv/iYSB1zi+4+dox
 CDyi9Ko1sFfi3KQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: 3ZarXwESIfEkUa7cBa-fI8uBxB6yMiVW
X-Authority-Analysis: v=2.4 cv=eeUNubEH c=1 sm=1 tr=0 ts=6a0c632f cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=TFgmKHP77OfOvYwKDSoA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEzMSBTYWx0ZWRfX7jeI0saIFHMp
 tdCzYyuVqEU0vfCPUtmJUBHarcE1brCIzVcgQzc1nY9II47ucu7HYRqUgPTHUyTCVnGFtvISmdd
 AX9TjbeABCLNQK3Va1v+twDrfniJsEoA/xc7X+AQyaRa3Ik/rL+nf81rhyM3YC1eAcvkvzf+OTO
 2rES14m300QaJcxiYuviRejUW+iFJtpKHDMh2hkD5aXuqHeeSiDEua1/MWE8APioaIGutLauGuV
 g1pASMTXBCC2gLYMKQWCFTd+BCrk4nuz5iLJ8FyttO+b3tVGcqxz3ysUhja8n8Y3rfQSMMQf7JU
 QopRH+ppq3L1JRCQj7EimoJy9571JSj8KAZ9KSkjNxyDsDGpptSrLDrBn9Lp2fPWK7sgdqB2D0B
 pWnwzFknWvHg0wFZUSVCtF/X26o3Gpki+GkJplc/uMQDCG5v0jfvIwIgQnyb25ObPzqdbLo8qe3
 NAz/H97bzY+o8daOR+Q==
X-Proofpoint-ORIG-GUID: 3ZarXwESIfEkUa7cBa-fI8uBxB6yMiVW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190131
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10549-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AB11557FB16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In order to communicate to the BAM DMA engine which address should be
used as a scratchpad for dummy writes related to BAM pipe locking,
fill out and attach the provided metadata struct to the descriptor.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/dma.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index b66e6386fccda20d9462e70e51b8b485be85dec8..97b0f02c2b4d212f9e9ad41bbcb3a33e0b64835a 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -11,6 +11,7 @@
 
 #include "core.h"
 #include "dma.h"
+#include "regs-v5.h"
 
 #define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
 #define QCE_BAM_CMD_SGL_SIZE		128
@@ -43,6 +44,10 @@ void qce_clear_bam_transaction(struct qce_device *qce)
 
 int qce_submit_cmd_desc(struct qce_device *qce)
 {
+	struct bam_desc_metadata meta = {
+		.scratchpad_addr = qce->base_phys + REG_VERSION,
+		.direction = DMA_MEM_TO_DEV,
+	};
 	struct qce_desc_info *qce_desc = qce->dma.bam_txn->desc;
 	struct qce_bam_transaction *bam_txn = qce->dma.bam_txn;
 	struct dma_async_tx_descriptor *dma_desc;
@@ -63,6 +68,10 @@ int qce_submit_cmd_desc(struct qce_device *qce)
 		goto err_unmap_sg;
 	}
 
+	ret = dmaengine_desc_attach_metadata(dma_desc, &meta, 0);
+	if (ret)
+		goto err_unmap_sg;
+
 	qce_desc->dma_desc = dma_desc;
 	cookie = dmaengine_submit(qce_desc->dma_desc);
 

-- 
2.47.3


