Return-Path: <dmaengine+bounces-11841-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8YT5HJNDQmoz3AkAu9opvQ
	(envelope-from <dmaengine+bounces-11841-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:06:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE676D8A5D
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:06:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=gzTrnZrI;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Q1cYARWV;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11841-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11841-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E37B6306D279
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 10:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FB63FC5A1;
	Mon, 29 Jun 2026 10:01:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C5A3FB7FF
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:01:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782727296; cv=none; b=UX2+ZWrGF1JlQ9YaC7fOw+3+h4q0g2Rt6PqeXMg+jXdUFOVibi+o4Pirih5mGEaFdW56L+UAAdYe80YKMRHtLNjYTCi2jFXcj+gBrQJhWN+oitszmq9Q1Nkvw4rJuohbI0dW6Lg+s/f6OG+MxmpwRksBKgp31IFXDyRQbIN8wZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782727296; c=relaxed/simple;
	bh=4nbFs/xg8cCMPYrFtHWE96AOtkhXxC7yUgPXEapSLFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dQHCfykMEIV/LWs3atHKpanPAGEHA4HEIUjUw6RHZwmWHG/sEkzhN6L6K3TXkfrSkXdVMdvmVhK6T8MYx9s6omUDllPxN133rS1y+eKv4CSaS+dZoBUpnC3YiCLZBleImrGJKo/oxADbdFC+AJbvV7Q7oCvcMaNa67yS77uIwi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gzTrnZrI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q1cYARWV; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8O7F12348324
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/Vh6sT+8mC4wwsdE+AaqQfMuc9K2i5dAUjEpzQ2UVhY=; b=gzTrnZrIWRjyuGAM
	OyqYjnhrfy0iiRcMz6IpRLtA4E4RQT4QnGZxauvQUtztx0+CSnejiKqcH2Cgfpxj
	JpK3wI7V/6Cg3/B6km6VMu5IFeoSEXwXZYriiU1DzNISGTVIOQxH91+xD/rgtsjZ
	b1d/c/c7dGSXSbw6Yue4Hsb4bEhwtSVM+xvy7R4DEJ+3jgoAIU5Zcm9OJUFuujAA
	ICiQ8IGIbqUV+cn3gtjLDY/F0qDwPxWQTDnce5GFdEAaWSO81keaCs+D3+SEaLa1
	ghAL8+sVy6IPRtPDrthhz3TUm+qBVr2ySb83MTr0Ve29ErT2kUqySWo8a2FjZcmO
	WJnhDw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3n5s0e1u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:01:33 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-969289fca9dso682325241.1
        for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 03:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782727293; x=1783332093; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Vh6sT+8mC4wwsdE+AaqQfMuc9K2i5dAUjEpzQ2UVhY=;
        b=Q1cYARWV1dv6F76oxQAWIvbAo91MNdHI7m0A9Yuwq7+cfSUmqrBvfDJqHy16ZxrQtC
         xs7WzwMxj5ep0LBb6v/YFJGYUIsOXQZqVrYZ4pHegwHHjXNVTZlLSP6CeTSgEQf0I2PY
         s/UL55tsjV6RaHadP49tR+8OJGiB91NRy73dhtJuXUWWUfxXeRg3YvswcUs0Qh7LQMoU
         /Csajdl5G98vnpUiqfuerUOXia+3wdxxwemWVnxLskjblpJouQfIXUDjjo9JbHBUdkvt
         wNiIh3Ho0msPTZ/V1lKLkePs7kIqRfHQaMSfqP5aouevUxPYYxwjz1Id8K6Qqx67gsUo
         8EOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782727293; x=1783332093;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/Vh6sT+8mC4wwsdE+AaqQfMuc9K2i5dAUjEpzQ2UVhY=;
        b=nYrUfu+lJSbA7gSWA4EuwwH+AJCzqWwXwaxjrFrCRK8a6WFnfQN32b+ilkXaZJzygk
         IuSK4OF4ixVW5hNgh5tYlog3Phlj/fLuqMLJDIgTI1VFEvBPNdDLVKASujXEuPFTKgif
         jGEexnlq1F8Gr3O+fSNzJDkuoqNPu69P7MbuMXdDnolZOKf6fJ6ujF/ebbls1cXJG3XP
         LvgNyKBsqiI92TbMmMdwM9C3Tm9KGEH7ezsP+6k9Bc3Sx+5Clskl9jj6s/iJHTw+WgWS
         haAP3AepHfmXKvxr+ItMcSFq1nK3UvJ2Npugp7VptajVEPkZ8/j9JyhGWHdBBMqdY/xV
         nujg==
X-Gm-Message-State: AOJu0YxMEpVWO68w9kU8bMJ+VjB2FsJ1gRd0fL8gj16DoNMTTw9Uxp1t
	kiYJ2ceY+0zqDx8jdCFEYfruIe4e7TDS7PaKJg278utPnL4X6viN0L+TARIhsTDtD5aly96pBJz
	HVsx3BiAH1ZwVhybARzFpN+BMrh4qIxCJKfVLrOhrhXu6R4JprouOX/E0m9zlWtA=
X-Gm-Gg: AfdE7cmrNBrd7TB6Xh4dUHncmjrdHQMYNTYNl5psi+RfvP3LEyFYrQWjfM0h9GCShJI
	V4JIV825pgB0k9nRlH+JK7km3/yrINTAg7FX5WJqA9ar78nTUwrHtDkrE8FK1MaNLW5SduHa6oa
	WZImM6J9fT61O+IZXtlv8qvY4ZihAOzcEmwL20Q/11Sp9k5PW5a0uPtYBr7WLosw6eiXmSHiu/N
	ZaM3XmDGxeMW5Q80/k+Gx3E3zWP7RrT3zUAEEfnypVPHIfdoG0KhnmVSbvWHvafAEGD9vqu6yCe
	9a3TH1bPaLD8VTE9POyAi6tsG418sXmS5eaMeN+BIb1Y3T8fy7uZHcWg/igjvA7ZuCucyozJeIK
	pBh9VLscm0k+zV7qAeyOPbK0UAigyepT167cozI/D
X-Received: by 2002:a05:6122:d1e:b0:59f:8ddb:2fc1 with SMTP id 71dfb90a1353d-5bdba9c61c9mr18228e0c.7.1782727292829;
        Mon, 29 Jun 2026 03:01:32 -0700 (PDT)
X-Received: by 2002:a05:6122:d1e:b0:59f:8ddb:2fc1 with SMTP id 71dfb90a1353d-5bdba9c61c9mr18114e0c.7.1782727292310;
        Mon, 29 Jun 2026 03:01:32 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4705f8ea729sm24729405f8f.0.2026.06.29.03.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 03:01:31 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 12:01:04 +0200
Subject: [PATCH v20 02/14] dmaengine: qcom: bam_dma: free interrupt before
 the clock in error path
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-qcom-qce-cmd-descr-v20-2-56f67da84c05@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2818;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=4nbFs/xg8cCMPYrFtHWE96AOtkhXxC7yUgPXEapSLFc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQkJprRUolPJe/4YhzQT31Z4wc6r48G51XF/tZ
 KO2XV27o42JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakJCaQAKCRAFnS7L/zaE
 w7lMEACqSAAoFegCmmR20sFZI3Mespj76ohU3JQKkxAV9V5VZxXj5XItwyNXet4kzFNbH23afZ3
 yr4yHbPwqVpoXvNtfSgygW8aMeDD/vMcaYVNe/3CGcFW1bvIrWcCqpurlHhXnq++HywTbG7vMQp
 bDnYIaJNOP/GS9IeJXaJC8jQFhT7nNU7vGfnzH4BtRztLopZHPVMY8NbvtRkoJY9T2JNJQnMikm
 2OznF7ujrCXqOaCHHY35pVRRn5ggbcYyNaoKXwAP7d+qVXZuJoK8X0UnzXVJjaym+75FzB8qA8E
 VYtoq5wg2cDbPiUeHGmE+AZE5ydHJYba4RlIIP4Effx/DIPOCcymDrN3K4+CoUkm7WsymNej8Ac
 jTpTuxFqirZ873P1LK3kvuAc73WeVm0T2GogHvqS95nWuN3usU6kqZv/iEnJHXqAt41ihzWvalU
 T5Lna6D2rH24MjRzs1iBGrWhvOZq+h9YwmMRdULsPwA18h8f4d5l75QkxOZRYyihnN8Dlbny9oq
 lppF78b+HZbc0xSDSU0yHX4yyqL7kURJrOUDJrlVIZi2GONLlWg+ZAYX4cGy2++i18CQmxjRuI0
 bPwsq+Ou+WNm7IhVZxWwPeMl4vreTn4Xp3M465IqabQkFBA56XkQ6XYbck9gnUyGzGrrcR6Hqpf
 3sLn8EyqyWe0FDA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4MCBTYWx0ZWRfXyWXStv5N1t0p
 zGePp9paYYh1d6ZkWCKaWb6alZTJbqZR6ltpm1c0KwczlNM85o6/JnP1xWlPuloZ/y8DRJszITb
 S2ht1rL+qhI2n+YlHRnVjm/4ofFvvT4=
X-Proofpoint-ORIG-GUID: 8QyNyPdbBhf_SlNksPiQS_K4a5UWkliW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4MCBTYWx0ZWRfX2U+jh8evM7gM
 PyHGvxKh3blOa17aEPhoKDmCaNr/17tEbKmIhzPN+krrefeVvpnwf6fYVW3oUTvQ84q+HNec0Gi
 VmoNzah1UQjOfw2isxv0dxOR3XvzI2rCs8oSBRMRVBQWB1Hf0jga55jcRB3doaw0BJ20QnLgioa
 GhTommuTalxS5AsLH7kucEEn1h0eKaNrbC1RSSYtyT21K4PN66/RZzokXbAF7qeh0aSoHXS1FFe
 65QV4OcpPoecjHf5VsL4w656Nl5BvfIhokFaiTloqBRcdgo5Nvh6y6FqNi1YXXx1vh6ZRSUuu5S
 DMm4S2SwzFi9r3W3MTpOfUqNqVAXU50d4MQe6dIciuRO38SIbMQrOP+8Ob69fufl/P6jAX2R1l0
 y+AH7juId3k+5LGr9DFK3MkrFDwZPNbW7GU84bFLCuCS3ocwZLWGOIlJg0YNqbHLLunPBWVXPWw
 3kuuo8XcPmFt8zbv1BQ==
X-Authority-Analysis: v=2.4 cv=NZzWEWD4 c=1 sm=1 tr=0 ts=6a42427d cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=n8zAjjMAgf0wD31B80cA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: 8QyNyPdbBhf_SlNksPiQS_K4a5UWkliW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290080
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11841-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:corbet@lwn.net,m:thara.gopinath@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:quic_utiwari@quicinc.com,m:mdalam@qti.qualcomm.com,m:lumag@kernel.org,m:mani@kernel.org,m:stephan.gerhold@linaro.org,m:andersson@kernel.org,m:peter.ujfalusi@gmail.com,m:michal.simek@amd.com,m:Frank.Li@kernel.org,m:agross@codeaurora.org,m:neil.armstrong@linaro.org,m:dmaengine@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:brgl@kernel.org,m:bartosz.golaszewski@linaro.org,m:bartosz.golaszewski@oss.qualcomm.com,m:tharagopinath@gmail.com,m:peterujfalusi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sashiko.dev:url,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 0EE676D8A5D

The BAM interrupt is requested with a devres helper and so on error it's
freed after probe() returns. We disable the clock before freeing or
masking it so it may still fire and we may end up reading BAM registers
with clock disabled.

Stop using devres for interrupts as we free it in remove() manually
anyway. Add an appropriate label and free the interrupt before disabling
the clock in error path and in remove().

Fixes: e7c0fe2a5c84 ("dmaengine: add Qualcomm BAM dma driver")
Closes: https://sashiko.dev/#/patchset/20260427-qcom-qce-cmd-descr-v16-0-945fd1cafbbc%40oss.qualcomm.com?part=2
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/dma/qcom/bam_dma.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 1bb26af0405f3a16f97e0d4b86c945c252d97f57..fc155e0d1870cbb7e099a2c4280f9f8fbdf6cf15 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1332,8 +1332,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	for (i = 0; i < bdev->num_channels; i++)
 		bam_channel_init(bdev, &bdev->channels[i], i);
 
-	ret = devm_request_irq(bdev->dev, bdev->irq, bam_dma_irq,
-			IRQF_TRIGGER_HIGH, "bam_dma", bdev);
+	ret = request_irq(bdev->irq, bam_dma_irq, IRQF_TRIGGER_HIGH, "bam_dma", bdev);
 	if (ret)
 		goto err_bam_channel_exit;
 
@@ -1366,7 +1365,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	ret = dma_async_device_register(&bdev->common);
 	if (ret) {
 		dev_err(bdev->dev, "failed to register dma async device\n");
-		goto err_bam_channel_exit;
+		goto err_free_irq;
 	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node, bam_dma_xlate,
@@ -1385,6 +1384,8 @@ static int bam_dma_probe(struct platform_device *pdev)
 
 err_unregister_dma:
 	dma_async_device_unregister(&bdev->common);
+err_free_irq:
+	free_irq(bdev->irq, bdev);
 err_bam_channel_exit:
 	for (i = 0; i < bdev->num_channels; i++)
 		tasklet_kill(&bdev->channels[i].vc.task);
@@ -1401,6 +1402,8 @@ static void bam_dma_remove(struct platform_device *pdev)
 	struct bam_device *bdev = platform_get_drvdata(pdev);
 	u32 i;
 
+	free_irq(bdev->irq, bdev);
+
 	pm_runtime_force_suspend(&pdev->dev);
 
 	of_dma_controller_free(pdev->dev.of_node);
@@ -1409,8 +1412,6 @@ static void bam_dma_remove(struct platform_device *pdev)
 	/* mask all interrupts for this execution environment */
 	writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));
 
-	devm_free_irq(bdev->dev, bdev->irq, bdev);
-
 	for (i = 0; i < bdev->num_channels; i++) {
 		bam_dma_terminate_all(&bdev->channels[i].vc.chan);
 		tasklet_kill(&bdev->channels[i].vc.task);

-- 
2.47.3


