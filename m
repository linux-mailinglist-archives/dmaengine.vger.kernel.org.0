Return-Path: <dmaengine+bounces-11853-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XotkKSVDQmr72wkAu9opvQ
	(envelope-from <dmaengine+bounces-11853-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:04:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 405916D89F6
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:04:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=YIXuvzLa;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Y+IWQLx0;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11853-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11853-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94AC83021CB6
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 10:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA76402B99;
	Mon, 29 Jun 2026 10:01:59 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298924028C0
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:01:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782727319; cv=none; b=VzeG20pcmx3muBCdDwTxFnwRtsVlXHY62zavoN/LioYbJY73F8eYhSLc5pOohLFcx/9vkSULfpvQwxeNT0NROwiF+RBHlezIprKjQKqyliRSpksco0+GX7OBSdAMSuvfylP3VhdLggyIZTBpZYMYHQon3Zvrt/hMSPp/vO/SD0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782727319; c=relaxed/simple;
	bh=haVTCoWg8OL+rLPtFm5RXGk1TNPHvQOhQxIunu3z1Cs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H8Zpe+HgvCBb+w+e3a8AU667HZ1Nk5Tl/SWSx9bPEKX3XnScqTq01RuKY/AeUC4E6ttLAd85o20jSGpkJ+ffxacfScS0mrVL/xzHCHfMzEbMmZRqGxSckg8KWEupvtfO4lWkURDKA66cIM/BIY54pe54K7NnkDeNPgRbm4xr6yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YIXuvzLa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y+IWQLx0; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T72bw02163943
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FYq1r0spQWHIRnEkazipWdL66tm0s91r38cl3E1vzGg=; b=YIXuvzLacZYnqiSb
	CzrRDe+dMXsdYCCdX3g7YG6MtxnfICNR5W4QevQ1v7tuONtJYn4NXjq5cW+RnOBr
	sdCwtzMnRWUYqU6xjgoxiSVTNjsW3bJ5XsGaBakYEPvhiNvMkoz4dK7ZlPpC6Rmc
	+jJvN2utmNijtow/ShfesUkbREbFG/XqqYoos0s9b7jOkq043R9JaL2Sl9iUhnmT
	OKWTxwPHMLIfi/1cmlakDFHDCgOrovPg0Bx9d3vHz1q/77G1HTFhmUekxdX7qlVJ
	VHprQQ0A2oQC1bo7TR9ho0meo/YV0bdG91kr+LefQMHlKUmznLYGMC8IlOV/DkVQ
	pE9eIQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kyjgr0n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:01:57 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9694e84752eso694670241.0
        for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 03:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782727316; x=1783332116; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYq1r0spQWHIRnEkazipWdL66tm0s91r38cl3E1vzGg=;
        b=Y+IWQLx09TAy+rwHsM1ujQj2QVpKvSDb2UANRnaNYUgSwNqfgYYczdKauMdfLb18O2
         usblVR/iL6lonABxe9AV/OMnVUZTYjuu4GWYVMrw09HZrwJAaSKy1y9hE6jjFZYAlf8/
         iAtc5g0aYMtOBPnbj5jSp8AUY378benOAPo7gLGEArO8dIzMYe1CdqB44jBg65MI3NgR
         s3b39B8O/Z2H3j75PbT4fnOGccmpJoCBZPV+Hb25HB+Tb42b8MXyP4eAFeHpA4jTFxRt
         XmbbGQ3uH4doQoKatvPnsWaJuma/q3p1D7i/cYiPcXcndfpIG6jfI3ssY0zlvXhrtw0S
         q//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782727316; x=1783332116;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FYq1r0spQWHIRnEkazipWdL66tm0s91r38cl3E1vzGg=;
        b=mZq/2hIPwaRYO6CdtX/ujUsvK54ShxAqYNmjRvu68cHCQ/UfEWw8QMoTjKnM/Mewir
         3XxBvwhCcXFZQdi8SpbCzqugnA4E7Bhv8JrIFKnbcdPUpCWHX+SWCOefdLHSi3TSgcXi
         +bMxOQiGaUTvBXz3gzJ3FYxDexK4a26/l9vn1YgrtAuug5eH4y24C8xA+GA1x8HiwTvS
         MDfqzrIPFrBGMfT/VuAvDTqhwNp+f+8zDO2ElfyS7ldzwFEJIyC14uR6RcDyQ5tWuyI2
         D4guSYEgiBQjiNRnr7Yolwa1bdgKPVWsc2UYRHc0tR5U2GBQm9z+dilQ/GwtGWHkWQbG
         8cOw==
X-Gm-Message-State: AOJu0YwTB8AR+ttwHOrP4l6R01uiY9gKcibnCCfSrJgQfGnLVtboymED
	rhJZ0oQ3UnurW3ZDoxAIeBjumsSnOsJ7eSJvRzA6ViGaq+TgS115H5bLBg6waiH6YazkqaBdjVE
	rjPeUomeUzT9jFL3X4t8GbQSZrFMr/Vq263NvyHiDq+2w74GUlDdDSo7fOEonj7A=
X-Gm-Gg: AfdE7ckZlB4tHfQL0VG//t+m6S4E4buT0DNvNX0RM/FzeYnvZCFq78+1VjhFd39T37M
	VC7pZ+IDQm1q9I4qda9ZGhoreIC1jUqjL72iEdKMLPg1aaQWPuQcueykLufPPI/q7EgvQuHSsMH
	g/L+Hq+UQ+xdy7hBbq+LErIoVOE9XzafRGYffUgT5ilYafmE3EJWufuJJ9iNxwELNxxAG+IJPhP
	0CoG7JApFtcCVwNh1mjTxm41XYChz7hwvvZuEDZv3X6caQI1ZAH49wTB3rJWbERoMlX86WkAA9a
	pWfxgnUV/avKK/Assx0N6hnFFy08h1LKeka1df5n+vct0+DJhTSQvqSCArVwqQ4Ub3tCHrYXnQ7
	6r/6RzrQjhUnz3jkxy9ca7SRtph18bG77+H1Tz5ah
X-Received: by 2002:a05:6102:149d:b0:726:9f22:cfe2 with SMTP id ada2fe7eead31-73436de9f31mr7722439137.26.1782727316400;
        Mon, 29 Jun 2026 03:01:56 -0700 (PDT)
X-Received: by 2002:a05:6102:149d:b0:726:9f22:cfe2 with SMTP id ada2fe7eead31-73436de9f31mr7721790137.26.1782727311120;
        Mon, 29 Jun 2026 03:01:51 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4705f8ea729sm24729405f8f.0.2026.06.29.03.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 03:01:50 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 12:01:14 +0200
Subject: [PATCH v20 12/14] crypto: qce - Map crypto memory for DMA
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-qcom-qce-cmd-descr-v20-12-56f67da84c05@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3111;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=zlCDdZs7gUpD6zwuSqo1JfGszglD6fOxI/qdoCA4A3w=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQkJyRptLKWkFSoJIGPvznI9GKRfKmyppf3tWA
 BSZbodxp2uJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakJCcgAKCRAFnS7L/zaE
 wxxzD/wMiHsQpOHVGOx0kVDaIxPCpm0/tDwTlpHNL+qKEBHi6quRR5TG8NOiukTYRVK+6FxEkZX
 DcGqpmG3mYwYU5kZaL85C6Ty1mgRsCfbByAkcR9FzBmA22ycBqju6f35Ado1puSW46bT7BKdi/f
 ljcImwjZTd4jwu/gaH1Iu6wtqVhKNlsytTVoI4jAvjsyoZVvoR8WNWSRQwLdcUZFgIzlZszWE3U
 2gldJzjpvBZ6O4guYqAlUfqjU9NtY4Rom/2gxUdedEm2coz9fPdKfRiszhsy/hD1rVasJUaYmMg
 Pko04lqrxjZJgIq2qfAVFuX3OqoGMVgkLgyi4i0QONDvSjjf7dS1z30s3DSBGRQkvBVEgBdwadi
 HpugOWzftaqAKvqpv2J6Z0iMD+H8TVGhZ7NqQ2AWxAINt0ky0RVAekbD3ALQFTbeB2YzvhHTQD7
 lMzWlCBwg12LNx5M9/zt+eaxlm8RZiQsBXabYdF+AhE6JK95vHEbs99G1mB0iD+7gr+g6LdVM1n
 AAm9S6Bie98pYVwvYFtXpnRdSqEgZvge5DQwzy8Ngj2r/wL9xSp/W7e2bQsOyHLZTnYXcZG5FSP
 GyAYJTqhA/T+OjYFaRwic/nvMS0zcRRNiv/JHA8mxkxBbCZlttHFAu5rguhmHY81JnTCXpmZiR6
 qDBCxA8HIdFiRhA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: GYi5Cpsz8OoJxbD3kJyq_9CbUQs6tuPt
X-Proofpoint-ORIG-GUID: GYi5Cpsz8OoJxbD3kJyq_9CbUQs6tuPt
X-Authority-Analysis: v=2.4 cv=Ftk1OWrq c=1 sm=1 tr=0 ts=6a424295 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=KKAkSRfTAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9tNk7rGwWxUH_P3zroIA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4MCBTYWx0ZWRfX34Y8U340kp3J
 VgXbil519L0uTCnG936DCFLxEC6xW2JgYK1kpuWgbGcFagbx89r5nfM0+O6mWLSLoBKJHpXkRB4
 /PtONi4OQhFgfgUL2EcUg/oCj1ZaR0E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4MCBTYWx0ZWRfX2vLm0K+P+C5j
 cis8qchnnXwVBy5bMOgGKBPiC9czv2WaYXNlQt6vtJSpTs2uYdX+sdvnTkWTQubT6rdwrzeJEJw
 795IIFEaEXPsx4x1RhFXMyplmvO73R4mcPoYqFD3QfDMfQ3vqxRhdv8Eh3s50KO+xHVJDFQcuKR
 grS3IFabZPqMlvqi6Fffyr69hnV5VMR/cV6mZ6fdbN0aKVon1mMCz5dce20k550MMBZjnfqObPY
 ffkOYW3PqnestDEwnVlN54c+FuF5NYngbOx3HwC03gF+pLlQnpqRfyiyTvv0WhfKy5U82KQBwNM
 3JksM0lOX+Oe5xGl1oEZkPLif7WbJTXXqTR7l8/Y6QVDZu4DQeUYscwtPEs4exaEMKf61Cs/dJq
 exLrHk78FahR64V+rBgCAPWFAfO48GGSCdOxdeUCcWzeGZQ2+GHFRBp4QxBqbnrA8OH25YgKHJf
 E24ed7+/qWivT8i4dbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
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
	TAGGED_FROM(0.00)[bounces-11853-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:corbet@lwn.net,m:thara.gopinath@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:quic_utiwari@quicinc.com,m:mdalam@qti.qualcomm.com,m:lumag@kernel.org,m:mani@kernel.org,m:stephan.gerhold@linaro.org,m:andersson@kernel.org,m:peter.ujfalusi@gmail.com,m:michal.simek@amd.com,m:Frank.Li@kernel.org,m:agross@codeaurora.org,m:neil.armstrong@linaro.org,m:dmaengine@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:brgl@kernel.org,m:bartosz.golaszewski@linaro.org,m:bartosz.golaszewski@oss.qualcomm.com,m:tharagopinath@gmail.com,m:peterujfalusi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
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
X-Rspamd-Queue-Id: 405916D89F6

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

As the first step in converting the driver to using DMA for register
I/O, let's map the crypto memory range.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/core.c | 23 ++++++++++++++++++++++-
 drivers/crypto/qce/core.h |  6 ++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index a0e2eadc3afd5f83e46724c8bc3e3690146b86ba..d7b7a3dda464964afe6a6893bb329d5bd5759dcd 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -192,10 +192,19 @@ static void qce_cancel_work(void *data)
 	cancel_work_sync(work);
 }
 
+static void qce_crypto_unmap_dma(void *data)
+{
+	struct qce_device *qce = data;
+
+	dma_unmap_resource(qce->dev, qce->base_dma, qce->dma_size,
+			   DMA_BIDIRECTIONAL, 0);
+}
+
 static int qce_crypto_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct qce_device *qce;
+	struct resource *res;
 	int ret;
 
 	qce = devm_kzalloc(dev, sizeof(*qce), GFP_KERNEL);
@@ -205,7 +214,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	qce->dev = dev;
 	platform_set_drvdata(pdev, qce);
 
-	qce->base = devm_platform_ioremap_resource(pdev, 0);
+	qce->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(qce->base))
 		return PTR_ERR(qce->base);
 
@@ -255,6 +264,18 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	qce->async_req_enqueue = qce_async_request_enqueue;
 	qce->async_req_done = qce_async_request_done;
 
+	qce->dma_size = resource_size(res);
+	qce->base_dma = dma_map_resource(dev, res->start, qce->dma_size,
+					 DMA_BIDIRECTIONAL, 0);
+	qce->base_phys = res->start;
+	ret = dma_mapping_error(dev, qce->base_dma);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(qce->dev, qce_crypto_unmap_dma, qce);
+	if (ret)
+		return ret;
+
 	return devm_qce_register_algs(qce);
 }
 
diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
index f092ce2d3b04a936a37805c20ac5ba78d8fdd2df..a80e12eac6c87e5321cce16c56a4bf5003474ef0 100644
--- a/drivers/crypto/qce/core.h
+++ b/drivers/crypto/qce/core.h
@@ -27,6 +27,9 @@
  * @dma: pointer to dma data
  * @burst_size: the crypto burst size
  * @pipe_pair_id: which pipe pair id the device using
+ * @base_dma: base DMA address
+ * @base_phys: base physical address
+ * @dma_size: size of memory mapped for DMA
  * @async_req_enqueue: invoked by every algorithm to enqueue a request
  * @async_req_done: invoked by every algorithm to finish its request
  */
@@ -43,6 +46,9 @@ struct qce_device {
 	struct qce_dma_data dma;
 	int burst_size;
 	unsigned int pipe_pair_id;
+	dma_addr_t base_dma;
+	phys_addr_t base_phys;
+	size_t dma_size;
 	int (*async_req_enqueue)(struct qce_device *qce,
 				 struct crypto_async_request *req);
 	void (*async_req_done)(struct qce_device *qce, int ret);

-- 
2.47.3


