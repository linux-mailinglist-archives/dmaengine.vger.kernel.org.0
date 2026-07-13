Return-Path: <dmaengine+bounces-12383-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GHn+EgbjVGrlgQAAu9opvQ
	(envelope-from <dmaengine+bounces-12383-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:07:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AA174B48F
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:07:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=M65MNopO;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=jXLUbkBi;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12383-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12383-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB14A305E69D
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 13:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498F3414DEE;
	Mon, 13 Jul 2026 13:01:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4614F414DF4
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:01:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947714; cv=none; b=ARnRYYitAS9qrrrBYz4sQeiDBKXAOaN/qOBsxQHskT4nkLH9je6CZTFpBJ14w7mv2tnNDkSZbIhue8T0VlM76sWZqH+v0j2gzxV6+5DuH/+kTlFmK4LT0/EVHpI9tKSeYRUUVnoEndRWoV9axEhMAhS8I6Xjh8/TwuMz1dYTeJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947714; c=relaxed/simple;
	bh=NNnz6awfeEqmEC/yqDO0GWP7yizfp6R665Mk39/3FRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nO8Y7L/hss12LYc3UZAMDTxtN27bQS1/J8l4247AmWXBeeQB3LUnLme4noJExm6BTChpLm59yLzOS/kxn4CShshg9k7wltL8dnNO/PDSjXtanhRj52FOGH2xgP94D2mLZMnM6x+DHulx38yokJPoqxhYhaK8QoBam9Bu4Qyvwtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M65MNopO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jXLUbkBi; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCDv3M1428318
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U1qOoj9SQUQgxQzB/fcCsnUQs1r8P8lLj6KzEKTr4FY=; b=M65MNopOV93GUyBp
	bGUu7yuKBO4aN3cADTUPCgFE7bxMQ4PD637A24sb5Qe/ZAqVyoQ7q7SgkHvOmAxa
	YiRejNlh4hBbi+bfuetDusp+OwSyIZAwdtS+aHQvY8mlhEWTkNynHTvyAgESCw6Y
	fcvoH6B2WNuwTGy4RYabcK5/W6N8AFy+ySotFo4uirWiaQBQjs/gJue7PavgkPV4
	IlKhXjfBuPb5gukA38rgslHphDg08RuvjrQsrJngomgplXt2UwYa7lg8ih7DmRfo
	4Sdi/T+UrPlh7y/thZhX0KP33e/eh1j0IwO4OdEfdub9X2R1HUykgvqpyTMpukri
	U5k6+Q==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcurn15md-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:01:51 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-48f0c5d20c6so5515300b6e.2
        for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 06:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783947710; x=1784552510; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U1qOoj9SQUQgxQzB/fcCsnUQs1r8P8lLj6KzEKTr4FY=;
        b=jXLUbkBiVJzqSyOoiZQM1xIzQMHn4pmxrygHtuFBqhRJ8VHUoIAELvYtLe8F7jAJEo
         QZJf3wYbzrCgqbWEta7hOx1PA/KfSomNDQE88cY9imb9d2SrePVtRXL/f8hDDgZcQP07
         WFq0zxMZGfPAxxmAKDer26eJL0l1fxNyoB/MYbTZOtOIX4Ocus2sPhvnaERRN+CGBnjX
         lbzjA6LTEp94gvU8iLUjsLCxkme2nuR2sRtInf5+xAcxFCCf6iyr26W+pLCqhnEmqr/W
         WtnuNX80af0hg/+kHZ1F7ATy6by6YLesxLpDaV3GlxjitjScpgaGDcBfTTiNLun/ZOZv
         Sekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783947710; x=1784552510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U1qOoj9SQUQgxQzB/fcCsnUQs1r8P8lLj6KzEKTr4FY=;
        b=o+UL+M2muWfmsoZ9JYeTvBRepxg1Ly8fIEdWqd87VlTOYXU+A/SDpznp/H+AieVQ1s
         Ad7dR9snJ/CwFEge3n1vpcb5D3W6hf4YQuP4y3iHMaTUexDfQsIWC2jkSE8r1lsy+dT8
         dDEPO/0Y5FNyl4DVk9QQKiVom5uPvT4uUSfxNCxWqgn81P9od7pUYPnIdFKyONHsnhVa
         ZFc0kbVisvvdNYzzWlwXPQP/+ZJTE7DVT8yfZ9UI67ga3atn6VN/HcI8Dx6gmuAGytHQ
         uPzQhhFCvExBJVbzgaLjy7EuH8mNaZi6gtvEADIMPeZRTvW0ZyAi/cOFAbkazOWKYHS1
         vNZA==
X-Gm-Message-State: AOJu0Yyq+fY5mt4GnFuVMiA4ade1hxUM8P+55vTXXcfUNefBVFOQ/Tra
	GHsLtMUQi3BRfH+MoaQpwGIfLD9MT2m7uyBrsRsyGxGUBSJrWAdxo1BdSQHKZ7zwOg9vauvAEhn
	ed5/ClPWnXvd0AqCAyk2hGsT2Q1RXzDOtkcz8Wt+3BWYPl6fgiltlXp4q+N5cGps=
X-Gm-Gg: AfdE7clgilOe9dfEuNnQ8/PX+OoXg/woNt2X3adJjSHgunKTvnchYwFKxzYXWb4cZ7t
	iRNKPb9YvNYQh+2+e6NieRFesCY1mPzBPxMlDcbCRmyb9xjgpOUTPV1ECr6aJXSj3vk82fmYKCR
	N/50/g2UxfmYbqQhr72rsNskdOAhyvMZYW3QpsWOWayJP1ZNYDOcjoWYD25DkuZu80xCR+eUTSp
	IdtW8+7pmetQczU0RoQUewdq3cXw69gbrSQ/f5YYiv2kxL6P5VsiMUlnjNQc3toLUeyL/BxjCDD
	KbNj36BX7aAQwoTi1WpuNrSiYf6CixexVcBQ2LWA5c6MgofHIsDxTjnPPSmQ5Wz5iw19UArjpU4
	m8oNZqGXaaSIdeItJ3zCixGEAbrq9LHNurdqzH0lH
X-Received: by 2002:a05:6820:709a:20b0:6a3:7976:704f with SMTP id 006d021491bc7-6a39a5b9a15mr3798675eaf.26.1783947710279;
        Mon, 13 Jul 2026 06:01:50 -0700 (PDT)
X-Received: by 2002:a05:6820:709a:20b0:6a3:7976:704f with SMTP id 006d021491bc7-6a39a5b9a15mr3798556eaf.26.1783947708525;
        Mon, 13 Jul 2026 06:01:48 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8881:83b8:89fa:1a2a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2d97527sm306129725e9.2.2026.07.13.06.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:01:47 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:01:08 +0200
Subject: [PATCH v21 07/14] crypto: qce - Cancel work on device detach
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-qcom-qce-cmd-descr-v21-7-bc2583e18475@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2473;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=NNnz6awfeEqmEC/yqDO0GWP7yizfp6R665Mk39/3FRo=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqVOGcH5zXrPcNI+T6P+/gycikSb+qYVbQi1DQU
 r+MiQXQlcqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCalThnAAKCRAFnS7L/zaE
 w0KCD/4yP5QoiE+i1I1Dzf1dFEqW7uoinT53GfY75/yhspqMCi7HzFWv3k/Fy/mD88OyK5AZGIS
 LRY6tDCfz1wOru9Bus5K67jEZgWlcWveAsPJrmsoaoRgJUP7sdCG1bkn5Bp7ODqCCHuW7zf14LW
 UmYMbCvmd5gySryeZUEocgI+sWvKLhBticmjTdanVKNNqsDh4jUxZn1NvcIkFMK171gLiVVEsIe
 QFsGfMP/AdcNcmSnlJy8bqbBXMTybZZ2+Mk5lZRmmYk1l4KBmHfyp6+s4McQCjip4ePxj8Itkh3
 r3XyPBOWSJAwOtNKStvuLxNheCdjccFNBlEwdZIfK2AmLlEWFcQkUO+ebCalLbT287JVhSezgqN
 hqIKxzTQ07014Vey1JqC2KzYWDfqdJ+5OAS1KoVlU0Y3ADY/x8U7yI6rJ9rebE2Sg78yV1GekIh
 Bz/lLUY2E1azgPj/PBQOtb15m8o3Cs8aP7JcXEiPJideSbc35+4o/MYKG46lkTzU6ypjPKnyye1
 Va6osQNaXPyKd2Royu6DliGPJWGT5Y3nBQWV76oM0IhRPKZBxFhAeuhi1cYJhHje92vDsgJPk6z
 52nF14H/e1UWFsqdgf/vnQfEOHSc/a4qMXqJC93+tcISNNptsbnhkf4Cp7YUPw+wZ40a4uuAYI5
 WCfSXCMXdhbo7FQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: _28wBTIwDdlqNtQfHF31Vr1ACRc-0-M5
X-Authority-Analysis: v=2.4 cv=IcK3n2qa c=1 sm=1 tr=0 ts=6a54e1bf cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=SDQHpg0AWQOuS8LWovAA:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEzNSBTYWx0ZWRfXyC7tEUTFxj97
 qqz2/BXpcCV5MP4pzkLaVwiM7kTPbkxnKwR9XT5jVi90DI8p1QwToDiniTSbe5hZox0Uhb02S+l
 KK88n8aR9ay6ORunzFCg25IfJvbO0vs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEzNSBTYWx0ZWRfXyHm6/c94jxZc
 BWiqJwT5dgzAMvLZx3lZk7I0mdTQ1PjYB8pHCj9YdeMYTTTmXoi9gwSjSmsAluXJk+UvaTUVYHx
 ngwiLGK6dTgAz0nM1erPSlxUP/AAZtHfnuv+G0yMzMYyMkg95YjHOd7/P0UrE8vuPqzdf0wdZjK
 bdA2zlmSDmhrmAIppW5q937xjRnakfOwHLAmNlp4kN82FBZk46Wk1tL8gg94Wr540Z85Q1ufga3
 jAL5JIvS599niYy9BsblrS5JcztB43CRaDyMRU7wZ3fOM5IpuHLm8tdhuisnCbVGcfW5gH+g5A2
 LzJcfd60Kur4oVdZ0aajOfgeMWgdcf/DKHjLyd0m4Rur5q6UBOAnpEXMYhGj4apTxcfD5C6XDCF
 VGqlSDQyhTyXMdC3qKGuVWlSwmdxbnd3tawbpionsTOKG24vq0mdtQIMcJf2ccOut55zQok9mam
 4t5BsOEke29wdwePWdA==
X-Proofpoint-GUID: _28wBTIwDdlqNtQfHF31Vr1ACRc-0-M5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130135
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
	TAGGED_FROM(0.00)[bounces-12383-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:corbet@lwn.net,m:thara.gopinath@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:quic_utiwari@quicinc.com,m:mdalam@qti.qualcomm.com,m:lumag@kernel.org,m:mani@kernel.org,m:stephan.gerhold@linaro.org,m:andersson@kernel.org,m:peter.ujfalusi@gmail.com,m:michal.simek@amd.com,m:Frank.Li@kernel.org,m:agross@codeaurora.org,m:neil.armstrong@linaro.org,m:dmaengine@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:brgl@kernel.org,m:bartosz.golaszewski@linaro.org,m:bartosz.golaszewski@oss.qualcomm.com,m:tharagopinath@gmail.com,m:peterujfalusi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sashiko.dev:url,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 06AA174B48F

The workqueue is setup in probe() but never cancelled on error or in
remove(). Set up a devres action to clean it up. We need to move the
initialization earlier as we don't want to cancel the work before any
outstanding DMA transfer is terminated. Make sure we do terminate all
transfers in qce_dma_release() devres action.

Fixes: eb7986e5e14d ("crypto: qce - convert tasklet to workqueue")
Closes: https://sashiko.dev/#/patchset/20260427-qcom-qce-cmd-descr-v16-0-945fd1cafbbc%40oss.qualcomm.com?part=7
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/core.c | 13 ++++++++++++-
 drivers/crypto/qce/dma.c  |  2 ++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index ac74f69914d6175b39ccde43f16269570fbcf715..b52a26ffff5ee733adcf4e8cf8bef75018dfa63e 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -185,6 +185,13 @@ static int qce_check_version(struct qce_device *qce)
 	return 0;
 }
 
+static void qce_cancel_work(void *data)
+{
+	struct work_struct *work = data;
+
+	cancel_work_sync(work);
+}
+
 static int qce_crypto_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -226,6 +233,11 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	INIT_WORK(&qce->done_work, qce_req_done_work);
+	ret = devm_add_action_or_reset(dev, qce_cancel_work, &qce->done_work);
+	if (ret)
+		return ret;
+
 	ret = devm_qce_dma_request(qce->dev, &qce->dma);
 	if (ret)
 		return ret;
@@ -238,7 +250,6 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	INIT_WORK(&qce->done_work, qce_req_done_work);
 	crypto_init_queue(&qce->queue, QCE_QUEUE_LENGTH);
 
 	qce->async_req_enqueue = qce_async_request_enqueue;
diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 68cafd4741ad3d91906d39e817fc7873b028d498..7ec9d72fd690fb17e03ade7efe3cc522fb47e1ac 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -13,6 +13,8 @@ static void qce_dma_release(void *data)
 {
 	struct qce_dma_data *dma = data;
 
+	dmaengine_terminate_sync(dma->txchan);
+	dmaengine_terminate_sync(dma->rxchan);
 	dma_release_channel(dma->txchan);
 	dma_release_channel(dma->rxchan);
 	kfree(dma->result_buf);

-- 
2.47.3


