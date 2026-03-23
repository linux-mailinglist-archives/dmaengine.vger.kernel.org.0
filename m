Return-Path: <dmaengine+bounces-9602-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KpsC6pgwWmaSgQAu9opvQ
	(envelope-from <dmaengine+bounces-9602-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 16:47:54 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 976182F6EC9
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 16:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AF6334DDA4B
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 15:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0C83C2764;
	Mon, 23 Mar 2026 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kGWZT4JS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E/dd8K3j"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B0E3B637A
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279058; cv=none; b=VHOwBt/KQ4rRX6sat8mTVjKPvLzdEWBZoVJw9T0+A20xp7T9TtDvzQ2yi/N3+7FeOeE+Oo+5ls797e/n5o+Q//b4BZYwGLs/7bhcWzLC7Yqv5gynnUptxLFzc/z8hH1a5HcquCYcVmDtu+J6A3n3ZGEQvW7nIyuf6cZWV8P9kFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279058; c=relaxed/simple;
	bh=qoz55FlU0wzlioVR5y4kqwZWHtjnuJw0AgLGnvGjRME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rrnTJ1KRjD5co+wj6StSisEvUjw6Qd1lqJkjdMB+8FePGwg/3bBv3MbWvuB/wYewjbvJ78pBCo+V9f6o2cCOQoUfWswPxfKiyGHhJFIHA+iLMZRRO6EDvzv//kfkK8nLpgy7XT126P0F4AMXUgkEyx43iKo7+Vc+yZevaquUSCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kGWZT4JS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E/dd8K3j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NFGiX83589370
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	byBhms6klEiQKAIzzwk/0xHdksfuhIUeiAfPpFlaRio=; b=kGWZT4JSkGl8CjPN
	gazARJCXqib/p/gf/2sz9fTaxkkLYcyyuohN70Ac7u/L33zWfS7gFrkuaQIEp0Tq
	zTBMLbOcgIstE3RzM4N/c0etFHtBN1e5nbRhrmJUMYFAl+dADPEt8+VK1Ns1qvKr
	nKyVk6vCeO50HIkiuyCaQLcr1s0PXq5zYwq/yG2yXG+i2b5UPCZsSnDCZHxWX2fT
	AfCTotJy8suo7HW11YTZ/eijVVW/po9mQB5d6IHhResj+ipR3iCs+kp1qGg+wRV1
	VXubeh+2feMFOzcA94QbyajLykGGCd/x8MlN4AgwBtAQhgspQwV8Dhq24ynfoMPw
	wTSXdQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d37a0g5ta-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:17:35 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-60280bcf80cso40570966137.0
        for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 08:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774279055; x=1774883855; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=byBhms6klEiQKAIzzwk/0xHdksfuhIUeiAfPpFlaRio=;
        b=E/dd8K3jC/rK1PHZk1p0ztNDHjXUqged1EJ2U7J4F6BhD2gaD4Z5/mfVJwZLyZbeWH
         u4NUyJrlZxTv+juF+Y0ibfgsQRMM+mA55aJaGrVYWW5j8mpF78eltJh3sawHKsoBL9W9
         1U7Jf1UZxJ2ESpE3FeeEzMJ44GS1xSIuAZd5Ghb0W1yAS+M0tM549zt6TtSQQh2iRV73
         cx0xQ7LZNdB+Dtl6TAoN//X2ssxlYO02pBlPhVPEhMnVY7Sfp7Mf39OqgI5u2SafjFHt
         g6meE/arYWOe/rgHerN9C1kFQ7V21tFfuQodajlqC6KzyGwySFmJRXJAHztPSxcJt2SQ
         6qXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774279055; x=1774883855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=byBhms6klEiQKAIzzwk/0xHdksfuhIUeiAfPpFlaRio=;
        b=o9wR/mr4WtrjT4CTIEjxy0NUvhQ+QsJ+yKFe0lmDK3U/jdEB0lhwsYg40/rm6OQFOC
         wE3jkMU/mGh5aB+hzNs6w7VbJzNk/RCeSzIzlL05g+JH3pZTXiWH4bve7lhCsH8rHRRx
         eaQJZwh/VtcKSiQx7rY5tbMBDFVmmNL+SDd+EYTPBiqGBZETmwhbONpgrtSQSYtpoDFR
         LFgHPMqOIE7IiVeW0ZbwmeVDLu69MV2wkaNgYefTuUphllf3VZoG8r3CXiyrL9tAlEzP
         F1mvkXPHMR1HahrQfO/pwXvvACemCMvn/nG9Lj82DTPqxAH8SKt3lq3pxp0b8Y+2cOvu
         Auhw==
X-Gm-Message-State: AOJu0Yy7amzcBkt0+PbUffY8IfVFgXI82RN43WMInMnEcAK7LxSNKfqP
	xs4cctXVMJuzmxyPoUBup1Dc4v+p2YoD7pgJNJvxAyfAK0jNVccjO+dfqcuLNiPRuuO2yBr2Fyz
	bhhZyB7k1ALisicidK5vmgwkARpmTeudU/FOxWmFDMSLDCrX82Og0xAKivAuHRx8=
X-Gm-Gg: ATEYQzzm0qJOviDPn+W5n0ODjXuHTPPIgtYj5FOLXEvZLxAd027ElLa/ickThr3hPf0
	CrFifZgw1+lm2blqgjC7BeiwuGmY/v3uXszOCJAws9HkMuCJJnn+tt6rA8QIVflbM9tId2lB2f3
	DE8YTrkdsa8lF93WSY61SgP5SY77FV1XBta/8GQojpnIwKtESDzezjCc4nod2dGDzXpv38GIkeI
	fmEnWCXcrrDpz6K0Y1dhnK7fgR7hpnF4TT6qfhCsZOE3MEwIw+eQMIVnQYVPxGu3MI72y53KszB
	LPG5FEdpCHRCbasQ/ESVBXFn1WBrP9h6MHCgrUxon9DRy/JnexLghOxH1+vzw5Blti+r5HrRN4Y
	U8/XnmAwReXuXN1oQQUTPSxIlT/iEJNHT/++FEIc4IjhIaG+ppbaN
X-Received: by 2002:a05:6102:358e:b0:600:1547:967c with SMTP id ada2fe7eead31-60295f98c4fmr8781922137.16.1774279054740;
        Mon, 23 Mar 2026 08:17:34 -0700 (PDT)
X-Received: by 2002:a05:6102:358e:b0:600:1547:967c with SMTP id ada2fe7eead31-60295f98c4fmr8781883137.16.1774279054168;
        Mon, 23 Mar 2026 08:17:34 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:f9a0:d7e2:7eb6:79b5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bd923sm35936993f8f.12.2026.03.23.08.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 08:17:33 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 16:17:09 +0100
Subject: [PATCH v14 03/12] dmaengine: qcom: bam_dma: Extend the driver's
 device match data
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-qcom-qce-cmd-descr-v14-3-f323af411274@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3778;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=RN7fpsHiCZHYCJzNDBLJB3M5MgjeycllWN+nZFNR5GU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpwVl8OLLyF9aeTIVtzCoOOIE2qZunIfV1911Bz
 KQ+q7C7QHGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCacFZfAAKCRAFnS7L/zaE
 w+1pEACjd+dBDsCtr9r99mTt1ag0OpCzQ64m26+B7AxCgmKG9elKjt+uDI7Lbr9X6xXdXa46L2l
 lz75ziRJCVpa06pdDEsdBgXnQogp6mjJv8jTmWNNLB/EU525xl8wDYo2xjomm5JNvwnUT798+d6
 ez+74vB01NIqS9UXW3w0tyIekSY1rYU/PgJ12SMJzs+detLRrLWUiFF740ISEPXnI5sAAolSBBK
 teYABzQBxUx9Ta56CKhdxNvUx2NhKWf/LFwVGlPWZzwvp+W/A9K/FNf+dd7nyc8JjbFtvHS6oVJ
 +LigW54tK5kjgEwBwU047ofr02PvrZY2NFm7xjSPsnuqwJs2i14Bk0RiQfSOSBF+L7I9QnHJOkx
 H30Y+LoC6IFiJko612QZ0s+aaZtdUAhLUb98kstnRiXt+53dzcXXB61/oV1/aM0gt1voH/2qf/j
 DbTX4FfEFQNuqio/1RzhdskCM7sCChm/ka7W5KN3gbc6dU5s1zAc0KThkz9SlaN6py19uqwq1bl
 VbzFq1kW++JjPONNpu0fHcwf8EpWWz8RQqRHC2GqNM88wVj1JCp70YlCmhEeTK0Etqmas/r6aWY
 zLxjZGEqugWdFfFnNlvuKH3V9Yz/Esc3uOnr88fQTDz7ybnDhEiXmBge2582PDx6djW7xYnqjy8
 xTEvcH46kzqM3iA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=GIIF0+NK c=1 sm=1 tr=0 ts=69c1598f cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=KKAkSRfTAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Fb6uNmSZeVr-t7npd3wA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExOCBTYWx0ZWRfX2gUUNoEe4/vm
 39EwkEr//3aNsxfIDrmpEsFWPUHynJ0OIQSp5W63VRY9Ozb0zAPGlw+ZHhGO7RWAJvKHOyp4ceE
 FxSucWPjW74oPrXLefvWMtEog28q1XBojkoEvL28twRZBZlEiWJr59PneiuFWEPdZGFmO1Nvshr
 CnVHOzI6FVU9YXivLw8dgLFm0Yanq4QoAr2ek5nQeYFtDp7oZXOP4lqzVhbIJEQ0mN1WwNXfKzK
 UEi1pfsa/s4jaKhMj7ru387xC7ndxjvWAOnXbft5LNzZUDuNcGzdllBiSn9sDhsofmabg45jq6O
 x5g7bQ7c74t3OV70x9tPXAay297fU4Hn3lhlw3NkWA94C0IXAO8HPYqimO1hvOw9jN/+6Tid9PT
 6UHm1n96Cs3ttgRxy2aSnogV9ech47G/jqZqcnTaXHK7gd7ReN5k7U2HueYGVHf5MZ4/uRFoobM
 kjD1bxu7lM3GHD2XSUQ==
X-Proofpoint-GUID: ryAm_cumJHsD1gSblr_sW11pVVzGR9YX
X-Proofpoint-ORIG-GUID: ryAm_cumJHsD1gSblr_sW11pVVzGR9YX
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9602-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 976182F6EC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In preparation for supporting the pipe locking feature flag, extend the
amount of information we can carry in device match data: create a
separate structure and make the register information one of its fields.
This way, in subsequent patches, it will be just a matter of adding a
new field to the device data.

Reviewed-by: Dmitry Baryshkov <lumag@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/dma/qcom/bam_dma.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index c8601bac555edf1bb4384fd39cb3449ec6e86334..8f6d03f6c673b57ed13aeca6c8331c71596d077b 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -113,6 +113,10 @@ struct reg_offset_data {
 	unsigned int pipe_mult, evnt_mult, ee_mult;
 };
 
+struct bam_device_data {
+	const struct reg_offset_data *reg_info;
+};
+
 static const struct reg_offset_data bam_v1_3_reg_info[] = {
 	[BAM_CTRL]		= { 0x0F80, 0x00, 0x00, 0x00 },
 	[BAM_REVISION]		= { 0x0F84, 0x00, 0x00, 0x00 },
@@ -142,6 +146,10 @@ static const struct reg_offset_data bam_v1_3_reg_info[] = {
 	[BAM_P_FIFO_SIZES]	= { 0x1020, 0x00, 0x40, 0x00 },
 };
 
+static const struct bam_device_data bam_v1_3_data = {
+	.reg_info = bam_v1_3_reg_info,
+};
+
 static const struct reg_offset_data bam_v1_4_reg_info[] = {
 	[BAM_CTRL]		= { 0x0000, 0x00, 0x00, 0x00 },
 	[BAM_REVISION]		= { 0x0004, 0x00, 0x00, 0x00 },
@@ -171,6 +179,10 @@ static const struct reg_offset_data bam_v1_4_reg_info[] = {
 	[BAM_P_FIFO_SIZES]	= { 0x1820, 0x00, 0x1000, 0x00 },
 };
 
+static const struct bam_device_data bam_v1_4_data = {
+	.reg_info = bam_v1_4_reg_info,
+};
+
 static const struct reg_offset_data bam_v1_7_reg_info[] = {
 	[BAM_CTRL]		= { 0x00000, 0x00, 0x00, 0x00 },
 	[BAM_REVISION]		= { 0x01000, 0x00, 0x00, 0x00 },
@@ -200,6 +212,10 @@ static const struct reg_offset_data bam_v1_7_reg_info[] = {
 	[BAM_P_FIFO_SIZES]	= { 0x13820, 0x00, 0x1000, 0x00 },
 };
 
+static const struct bam_device_data bam_v1_7_data = {
+	.reg_info = bam_v1_7_reg_info,
+};
+
 /* BAM CTRL */
 #define BAM_SW_RST			BIT(0)
 #define BAM_EN				BIT(1)
@@ -393,7 +409,7 @@ struct bam_device {
 	bool powered_remotely;
 	u32 active_channels;
 
-	const struct reg_offset_data *layout;
+	const struct bam_device_data *dev_data;
 
 	struct clk *bamclk;
 	int irq;
@@ -411,7 +427,7 @@ struct bam_device {
 static inline void __iomem *bam_addr(struct bam_device *bdev, u32 pipe,
 		enum bam_reg reg)
 {
-	const struct reg_offset_data r = bdev->layout[reg];
+	const struct reg_offset_data r = bdev->dev_data->reg_info[reg];
 
 	return bdev->regs + r.base_offset +
 		r.pipe_mult * pipe +
@@ -1205,9 +1221,9 @@ static void bam_channel_init(struct bam_device *bdev, struct bam_chan *bchan,
 }
 
 static const struct of_device_id bam_of_match[] = {
-	{ .compatible = "qcom,bam-v1.3.0", .data = &bam_v1_3_reg_info },
-	{ .compatible = "qcom,bam-v1.4.0", .data = &bam_v1_4_reg_info },
-	{ .compatible = "qcom,bam-v1.7.0", .data = &bam_v1_7_reg_info },
+	{ .compatible = "qcom,bam-v1.3.0", .data = &bam_v1_3_data },
+	{ .compatible = "qcom,bam-v1.4.0", .data = &bam_v1_4_data },
+	{ .compatible = "qcom,bam-v1.7.0", .data = &bam_v1_7_data },
 	{}
 };
 
@@ -1231,7 +1247,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	bdev->layout = match->data;
+	bdev->dev_data = match->data;
 
 	bdev->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bdev->regs))

-- 
2.47.3


