Return-Path: <dmaengine+bounces-11849-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lG88H61EQmoI3QkAu9opvQ
	(envelope-from <dmaengine+bounces-11849-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:10:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A576D8BAC
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:10:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=XztrSDxP;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=AAw3dxBt;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11849-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11849-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 804AC30BCE56
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 10:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC087400E0B;
	Mon, 29 Jun 2026 10:01:51 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512FF3FFFA1
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:01:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782727311; cv=none; b=X7k9t2NkaB2ycbjbOJ0LywUAUN6C4GWiWP4o+5oYWRwrhSJeek8DW46LJ6KcL47J+3+SUPWymLU1qoyNjPWCCdu3FRzOz1fbJ4wwFzo0wM3+81xr7WF5F2a+eqDbG8MLvLLvgdEuYFU49UPJsQad1pPIHjTyUCIhPnLHnp9rDlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782727311; c=relaxed/simple;
	bh=3yBeQNw3jzjlpjDFEUCe3Cu5wMqOMdw6j0aFa7VZxZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MFU5f05CYB7oPa/eocQh2F2Rog+HiEhoK0D/8C64XH/+eFU4GhVl4u8crVJZjzcDn/kdxKe2KLyhTC/OduF/QL3JueYuFiDjdf2fOGN51S5RAH6lSLheof20yDNqVLvcUzTJtFoXh8gUuGVuGSw5sF4KPCbI4WUG3Ck9qpu7z8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XztrSDxP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AAw3dxBt; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8OBWw2348369
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HYRuBcDmeSrwysgBk6y3pl9+6SWSAyowGbE1RPyJdFA=; b=XztrSDxPyclJi8we
	vRgiAtBVobJ+eerpJLvNwf1p5kAvzavzKHffis4m6GRbnKiQGjFqk6YU8xmRK/Dj
	ISq0927/c5LdfTKIPXZeAitwPTBLPQeDEk0JKwIUpe3kNvOgCnIu5XLxDOfk83a+
	xrkcZGbgYeuzdlN/jwonLtciBCisKFYel0LRQZEl7BlMb41ruYa8wzRyR6I8mqYW
	3vNCJ705lfoT+KAOuujn4x8RJBcz3bgCXdIB4fg1wRG+f8p5Cx74XZKL4XtgqgZ6
	xpzucLNybjVg93OTouKGD3UJD7xI+OuEsanf7h99aY9dsMjaxcqhJt1gQ92F5DrF
	6gA5ow==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3n5s0e3g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:01:49 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5bbd3241499so2736427e0c.3
        for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 03:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782727308; x=1783332108; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYRuBcDmeSrwysgBk6y3pl9+6SWSAyowGbE1RPyJdFA=;
        b=AAw3dxBtL+7R/cQtJda+XBb+tmwtYgGzetqHMmK6jAmvDzLrg3B7NPwWdqJlFci8JK
         nfvxXDfPGZ6gYojxxBSx+TNawdDzy/dSG9aPkfRCJJhO6DKv85xGgg1T7TtGaCnK/HB5
         7YoslMdww+teTS7l5XISI823wKb4Qpt9KaYPsWxBl0RkmkRp3dEABlTgH3FNbdpNpK9w
         guGq2GLW/N8PGJ4kKuy9qJRe9r4hTsPV2rcuGm0qfunrpcAbnB5ENtmgwcN9UNBq+tmx
         0S3goZFWvoUwrGxR1opWzZzVoPzq/HReGmIuf9pCvM7Hk4MU3VJz0cOcIZDWwkv0r37h
         eOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782727308; x=1783332108;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HYRuBcDmeSrwysgBk6y3pl9+6SWSAyowGbE1RPyJdFA=;
        b=H3sOtGvSWjgq22ZsfUFPsmYAVxi0P47slvAkraPlHHufjv3k1AK58xdb3GpnQWeLNG
         d8AJq2ncJGs0dL3iYysNJ/BkiV1s4Ufmoi7kTHQZSQMwTW1VcU+2dZ0m+vySJb/uEObp
         7862qNee8u/ahkrhNgaAvlyKbCljfjvnBy+rONsdqxKsfwLG4cOOVoE8d0peooojB1Le
         ceSpvIddd1CMg46XuZ8z6jCCpS2Z0c6wvPCcWq/+4oY4MFTdc9ogIHicF7f+mQ2QfbmK
         pB56yX023Xxr8BGZ9Pqc3/LPXb6Iwj2vYSPTzpjH6VObgiaDf6t0SPSWCnZMPmzsfCpK
         lYPg==
X-Gm-Message-State: AOJu0Yw51b5qeCqsLS4A+j2p0W+nuD2nHUwvyUG70hynRvn2o4QmqEFT
	kgqH5RQVbMBGe4sXMNXqCltLWGW1hxThXX0YOta4gbp6T1uhX/1gSjuCEFkIWIjbXZnDVgjiOTU
	XKCqahDfNyFOLVrDL/50yn4co8ySBy+kuR/kxVgKnAbO5r+zHskHdUQog6A/ns4A=
X-Gm-Gg: AfdE7cnkEyZLTEewT0ZfbGJBzLYQINy7YGdOBAlhXtk25GdiPL5vLBBW+AJ1TFLuIwG
	oD8WZQrvwMSfeUNGogGsSfXfuxs0sPrscqeZ8J1Wc8iINg4/o4DsvCQPq38TQ/C0xdHhxbsj4lq
	EqMvgzLYYbpc/GywVeaT18a2NEnSlLwUftXUS6D0I2FHhFRJSy36iVw13M4U7ZqIXR2MT76IMMd
	A7oQAOc5JejxKycuDXTc1wL2w1mf+psNGcWnJGRWHm8hrjO2Ese/2MKabDi/oH4f12Y0L9wb0s9
	Jd1hrewiKvihShYSywBW8KO6NGAHrGHAyaUwy9wFmye2YqupPIaJfvkD3zok7kEj+xzZOIn0VHD
	OmB8XtnCJzAUptVV0nb5uo/KeB2y61sl2JjVDNbGd
X-Received: by 2002:a05:6122:8b1c:b0:575:634a:a604 with SMTP id 71dfb90a1353d-5bdba8a339bmr27617e0c.6.1782727308264;
        Mon, 29 Jun 2026 03:01:48 -0700 (PDT)
X-Received: by 2002:a05:6122:8b1c:b0:575:634a:a604 with SMTP id 71dfb90a1353d-5bdba8a339bmr27486e0c.6.1782727307238;
        Mon, 29 Jun 2026 03:01:47 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4705f8ea729sm24729405f8f.0.2026.06.29.03.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 03:01:46 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 12:01:12 +0200
Subject: [PATCH v20 10/14] crypto: qce - Simplify arguments of
 devm_qce_dma_request()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-qcom-qce-cmd-descr-v20-10-56f67da84c05@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2674;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=fDLeS2ZDhx+ScijOniaw6DzPwcx1IpnjO8zSFEJey9c=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQkJxWoYdaECBMJU1ae5UmTpJ/sF45cGJdaurU
 vfvAW1JcVCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakJCcQAKCRAFnS7L/zaE
 wwkpEACzlOolvjYNbjF180IhoXcv1UxMesWJbsR+q/6GDNbH+H+8Y05PJSygIP0eesV6iOV9bSA
 sb/B32oxvvNkEOuf/+4zat7qcfOfqxpzqji4lotN5JPp6ATjXsk6yTA6UyKBGmH38zMieAV8DsE
 jeyxGxYU916OZctTn7CsnBJ/EaS9NhnwsvtI0Gp8VeBYS6AdvTBL8UkUXT/QQ2tGAiM2PFcXuBz
 czP5dJTlb2krm6mdRFXp/7Zs6OgGC45S9h1oK9pvxwp5UA73ohfkhg4/f87D6Wr9wv2d3Vq9nn+
 nEcExiMZGdh2wt/rjpILDQDBycJiKN/FWO8POtrF2w3AFA+6YxORycPUKMz/9DaasiLHCaoG5yC
 /BA4ccjFCH8/ycLcd7VGFSb/tRK3a8zoM0ilSPMpVahiIUN9QFNp1/1ZFyZA3aXqfoHeXdtrgXP
 rkP0g18Pe8GJwl96LpRgas3uUG0Jn+FuWoMdkaasUmNJtbjgqJq2g01n/qhAxaeFz6F3MoZdAkH
 y+UjR7eIjmfRpFpjvUiKPCKIA98R42RGJVlIdplsF+CdERgwQF2V2FHbA5nnRcbLph4OxA8T00O
 93KFIUcl1IO1UMfVHA691gjl/11QIvRk9fR2sLrNhkT/TBKH6Rsv8tV3SVolIYvx8jhMGJ3HNn6
 nA772RGyHavwIpQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4MCBTYWx0ZWRfX6wRl66dd6f8q
 tG1QoYmpEtS+EkEMW2DnIJ9atgWMBnQkdrfCQkjbGxAaCvY7Rb4DzjZwkYnZxyQUCbK/xW0WYQW
 mn910upUR0UskTULEb3ynn2gPp+QUpY=
X-Proofpoint-ORIG-GUID: LNXq0lYCLQKh7OR84T2KWGCaH3mgg2Ny
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4MCBTYWx0ZWRfXyLyGVK0355vA
 CG3YCD01VgdP78QGi0WswhDQDIV0FE6p1VYqFiAXDjDYKJneqAmejqICTvb5+0jFzpBfCiAM8V3
 bBuYJcflRE7Zfrmx4EGASdEVgBrXL0wIgOJmgvG7uZwNDytEw2xM2xJs+SVpZDAflz9RLPC/6FG
 E/jhoEAdm4hzpr0yz04ogipmAAe/xOQnwmQmOZ8GlMHGcs66NBvK4bf9NFQpoZMo1d0hOVyway9
 jd//gL+Mv1zd6hplr/IiqKFvUK4Dg6EspKh8ISZQOtQ+UbiyYuNb/YFB7QiwDPMvKAHh4UpE3sU
 Zw3Y252WuM1XL+2czzKu5M23uNlTQGiql3YhtJXomAhWYBce2M2qi9Zjqtn9vnKQi89RgmqcebE
 S+h2bXGXmLsB2b/gkcaf4frEQkBofZ6uhai//r6ZfLr9pAnZNWpNbV/4QBv0NryBKZHn3Kc9VaI
 QxjY12Onf35zYwURnlA==
X-Authority-Analysis: v=2.4 cv=NZzWEWD4 c=1 sm=1 tr=0 ts=6a42428d cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=KKAkSRfTAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lH6k5GM5CfRwGFUYfCYA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: LNXq0lYCLQKh7OR84T2KWGCaH3mgg2Ny
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11849-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:corbet@lwn.net,m:thara.gopinath@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:quic_utiwari@quicinc.com,m:mdalam@qti.qualcomm.com,m:lumag@kernel.org,m:mani@kernel.org,m:stephan.gerhold@linaro.org,m:andersson@kernel.org,m:peter.ujfalusi@gmail.com,m:michal.simek@amd.com,m:Frank.Li@kernel.org,m:agross@codeaurora.org,m:neil.armstrong@linaro.org,m:dmaengine@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:brgl@kernel.org,m:bartosz.golaszewski@linaro.org,m:bartosz.golaszewski@oss.qualcomm.com,m:tharagopinath@gmail.com,m:peterujfalusi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
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
X-Rspamd-Queue-Id: D2A576D8BAC

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This function can extract all the information it needs from struct
qce_device alone so simplify its arguments. This is done in preparation
for adding support for register I/O over DMA which will require
accessing even more fields from struct qce_device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/core.c | 2 +-
 drivers/crypto/qce/dma.c  | 5 ++++-
 drivers/crypto/qce/dma.h  | 4 +++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index ad37c2b8ae53a373bb248aff06c3b7946e8439a8..a0e2eadc3afd5f83e46724c8bc3e3690146b86ba 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -238,7 +238,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = devm_qce_dma_request(qce->dev, &qce->dma);
+	ret = devm_qce_dma_request(qce);
 	if (ret)
 		return ret;
 
diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index d1daa229361aa74da5d3d7bfe1bc8ab189761e38..d60efb5c26d88f8b0259b1dccc8724d0f75571c6 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -7,6 +7,7 @@
 #include <linux/dmaengine.h>
 #include <crypto/scatterwalk.h>
 
+#include "core.h"
 #include "dma.h"
 
 #define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
@@ -22,8 +23,10 @@ static void qce_dma_release(void *data)
 	kfree(dma->result_buf);
 }
 
-int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma)
+int devm_qce_dma_request(struct qce_device *qce)
 {
+	struct qce_dma_data *dma = &qce->dma;
+	struct device *dev = qce->dev;
 	int ret;
 
 	dma->txchan = dma_request_chan(dev, "tx");
diff --git a/drivers/crypto/qce/dma.h b/drivers/crypto/qce/dma.h
index fc337c435cd14917bdfb99febcf9119275afdeba..483789d9fa98e79d1283de8297bf2fc2a773f3a7 100644
--- a/drivers/crypto/qce/dma.h
+++ b/drivers/crypto/qce/dma.h
@@ -8,6 +8,8 @@
 
 #include <linux/dmaengine.h>
 
+struct qce_device;
+
 /* maximum data transfer block size between BAM and CE */
 #define QCE_BAM_BURST_SIZE		64
 
@@ -32,7 +34,7 @@ struct qce_dma_data {
 	struct qce_result_dump *result_buf;
 };
 
-int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma);
+int devm_qce_dma_request(struct qce_device *qce);
 int qce_dma_prep_sgs(struct qce_dma_data *dma, struct scatterlist *sg_in,
 		     int in_ents, struct scatterlist *sg_out, int out_ents,
 		     dma_async_tx_callback cb, void *cb_param);

-- 
2.47.3


