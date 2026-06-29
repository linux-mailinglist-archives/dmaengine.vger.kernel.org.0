Return-Path: <dmaengine+bounces-11847-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4y0jFSJEQmqj3AkAu9opvQ
	(envelope-from <dmaengine+bounces-11847-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:08:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D18E96D8B3A
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:08:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=LEg703f5;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=F7eq1ldm;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11847-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11847-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B915E30B494E
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 10:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF7C3FFFA4;
	Mon, 29 Jun 2026 10:01:50 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E9F3FC5C9
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:01:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782727310; cv=none; b=tTAQZd5H+V4l2E9uCtF3qNu/V8COB7v0+tkjfTgAX6kPWt5MGLdyKhhRW1d69JkUGNb+diupXNGBsupHU91UFPxl1ccR9fQU22VOb71/9CKIQtjoMTKb8oDHu9OvIAuJJ3SPswO2UDKRTDKlDDuOrgVqixXtesX/Rhdg6kywkk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782727310; c=relaxed/simple;
	bh=vpDVf/b6zHPEUgtVCAl2sRJELM4MLJc6gtP24/up104=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G15WWfuiD8Pq3N9hKd2AC0pft/yjlgrk/ZdKvh7nZTo7sMxreSFwE00TjYbOwkba/ZGUYPgiXwVQlP86kTEUohcif0vFSFFdKMarkPAyClqJFyJg/WctzJFWYrnaq8rbNjEf/bRaxRVPy42qlW+LpJXFLRn9faoRyPdEybGk7JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LEg703f5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F7eq1ldm; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T91N952400847
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	twry+rQD67k4KXlgASz4DIRuOCwVvltNp8BQTuA56nA=; b=LEg703f5oAUmJAal
	+gHU7nu0RU7bBn2r1xrDChXJ+FR4599Fai3eHgqxavOc0YxvdUfypUPymZG6KFQu
	fMqH/TDOTpyeMBTEQfuXW9GQHgQLsFdA4+v9nIgClCgdoOf0Qlfh9kUohbLTk6y1
	s2YGV5/SG7YNkVhNd5RuO5ZMziR/TKfUZPB6sJu68rxvB9JMi6+atAKgsVuYIwiW
	W5BuaRSCYmNdQmrelbUvRQZr8ncslfrcAdgNzLVki8k2h2XHcrBYpQKL8k336sCE
	46RZZkiz/qmDeNp/bD+wn1TIovRJYmLiHTKOFHo+xyDb6gEB6IVQE0sLXNxS1H15
	GIxexQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nq888c5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:01:47 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-737cd7b76ceso465294137.3
        for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 03:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782727306; x=1783332106; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twry+rQD67k4KXlgASz4DIRuOCwVvltNp8BQTuA56nA=;
        b=F7eq1ldmnYkz53SUv7HJ64/ow9eHXpV/0JVY9ucdBmvYgiQOc3TxhtwUWndXTaNY61
         sXjPSKTPO1UN7w0Rxnj1zUPaaSO+jVuDOX7ReeUTfYUXe9fMLWomUs7AeYLTVmN824W9
         JmtcxadcQQYa7MZLS5mEMm7f490nmVkaI9Q/CQjrWcq1enT2Q6WD/2MwzP60XlzJSB5m
         gnWKrRUO29fEdpXM+1OVHA/SC5vK87RZeeMsNFLZvIzuQb91KLOGMQ/DSyAzgjqRA+ao
         zHK4ulpdOXtY7QotPkrwZVa7mM+hjL4iQLjvP2qeS/oKfPASov3d2mtiC7Fk+32QKPc9
         laaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782727306; x=1783332106;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=twry+rQD67k4KXlgASz4DIRuOCwVvltNp8BQTuA56nA=;
        b=A5vBewmsgtL+DqgjoElZ644QODm25NpCtohr/5zEX43AJ8NJEwx9Rlpd/ZeMrz6ae3
         FfskZSRYt5VVah9uUilkRgewrBX4kWIu5vQnKaDoS+H8sWYe4jH5yngK6asW437QlT93
         g6m+MN4reiPlbpm4mj1I0orVGkVsZZ3n+VAapNKaR+mnl9E+xZ6SeyImJg/q6b/ceafl
         vSnWlJVAl0aF8kw4JrloNfXt2bkePfxEBXXV1GoeUR+ImHDjmIZZelSC+PBBUhNV5UIt
         QBq5aXfI58FAdPXq50OO7VMckNd5ROq86MP+ue/zBQ5SWILvI4RZANX18HRt8eqfV4UT
         g7dg==
X-Gm-Message-State: AOJu0Yzuo0k2B12YBJbko6I1YYJtAe/mhI+zlg6/wYUN/mKl7QaIfseY
	tVQtFn/uaDu9lqg4A8qC0LgNo5qGPRK6+Go7V6XkN5abaxpcbrOEe2J2sX8NNyuJmSfUSi8ZT9s
	MASQTOqDBxu/RaUatXmPM304pGRJ1oUo3zkEc678xVQ6Y7rbxXpANxp76SW6Yq2Y=
X-Gm-Gg: AfdE7ck5RL3hiS7vC5Dx+0juScRMF0Bl3KJXIKHTbC38m8AJhc1Dd+/70zDvczj4kdd
	JonypuAX/Eib/VlnMUjlbQMrWlEe/NJP6zfzbL2ogySY73QTdrHjssFW4u3egajrAXfO6D+AK8y
	bnqhApdE+tnTrUP6XPR3lsEZmJEfK7ZAsqok03zgoDpdk9uM/Tf16z2VanKTtyY0RwyzpzOfVD3
	3+PE/yubWYT4iUrsdaG6l959pg/8yDv2yAx+ZxkGxoJ2DGLnSbd5tewk098S+6pC40Pcv98/9dc
	y9582CuT/y4efA00q7CA0WmhBkDtGwXcQaXondybG/dxG1rfSJb9NccwfIH+v2pyEmkx12KTCeZ
	47UN4ksgfaCgST9TtUFnKtw7dryW9G0eGyQRqLKwZ
X-Received: by 2002:a05:6102:95:b0:737:e354:4092 with SMTP id ada2fe7eead31-737e3545ad3mr1196590137.11.1782727305976;
        Mon, 29 Jun 2026 03:01:45 -0700 (PDT)
X-Received: by 2002:a05:6102:95:b0:737:e354:4092 with SMTP id ada2fe7eead31-737e3545ad3mr1196526137.11.1782727305442;
        Mon, 29 Jun 2026 03:01:45 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4705f8ea729sm24729405f8f.0.2026.06.29.03.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 03:01:44 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 12:01:11 +0200
Subject: [PATCH v20 09/14] crypto: qce - Remove unused ignore_buf
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-qcom-qce-cmd-descr-v20-9-56f67da84c05@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2066;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=j6XY4tGbVrzzivRLNBnBuYRESnCKLFI7yXVP5haQkuk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQkJwPS7oWMhegzDGpn6W+WADbxymK6guX1y8I
 RaJU6CKoUqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakJCcAAKCRAFnS7L/zaE
 w7l4D/oDvOndI1JjwtBTY+Eg/bVcbRTNwsf0yYfaPDEt0LlPqKKKDJYkylNF8Ipu3XluJurf9yt
 gpAQVPC5wJsdY5ACa49GVUxlFR4tvj2/bvgLXhNCZJ+5qeWvnFU10wwIioy1ZZx+KnA2CgmWX3a
 EjYzP8n8WU8ob08iLjXkF5QCFJV9qt7Q3uKwZte9gMm6inrvXliFICfFtcnqxahFSrjexSZnvWA
 K9N5xBr4Hoi2nXUGELVaGOLJN5rCeZvuPeJ0HMdSKUQMq19297Dl/+DabLPQ8TM60NFLouknc6U
 6S97ZdznObH6VPHfqfYkAwRQsLMZd0nUpcRULDvXPKlutq+vUTePngIC4RBiUHKT2a9EDPFB0hA
 +ZY54bSMoAloFzrIiIjLIAvI3WxbuFaS817bSk3r0GOvsbiCuena4hqXzN4ozWZfX43O7paBc0B
 heLR/M4QLCGLcdKOFyCVu5Lw2YBIPNizbdx+HJLm7p8i6nSts5VBxcqEQNjOphoy9QrdaPm56Pg
 PiT2np59HB86JEk9KQ93C+mfdeJZyfsDcNFtUWdiI7b5I1YmG4fLbYbIKE746zHsQMXcpaT1Jnb
 +8OmA3oc+ikQqsN4blAe6LAwPIbjRwy0cJBUic3PzhK2DiOEaabhV1Z3oLKEDNDSy3iwAY4whb5
 yx6/YbbrfsT7ydg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: EmM-0x-wzhL2Aa_QoHhP6RHErG__1toI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4MCBTYWx0ZWRfX+oTPuvnbxkaG
 o3CWEpdLBPO6G+Hs4NiiSAA8IEuP+YED6dQO1WmpeBJXlb+2zvqlhGkuwpeQchSnRsUut0J6i4W
 mqwvvMe5EGOwFrKVR959LavpeinR9yI=
X-Proofpoint-ORIG-GUID: EmM-0x-wzhL2Aa_QoHhP6RHErG__1toI
X-Authority-Analysis: v=2.4 cv=PqSjqQM3 c=1 sm=1 tr=0 ts=6a42428b cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=KKAkSRfTAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tWRRbWwrKX-5tUpmLDIA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4MCBTYWx0ZWRfX8HueHV999Aoc
 ulJfvvMYkt86mUW9wjxm6Q3Sc+tWWP1SK4bWzdo1T/D3UMAAieldD++1184G23Gi0BCv/fnvkW8
 dnVKPTt1T95kJ/q0DEVvMlPx7nu4dhbGpaXe7bcEzMtVQXZO3+dYm3fe8CUvrOtdfa/B3Jo1eUS
 h6520nRD2QIhX/6WB/AdxBQ0K/jLgboXioiDk5bRQ+uPjQrjgMxSHBWbJ2N5BqjIDL0yoWwZrDf
 OauBpJIelvugIUNyIgY/a3CdqBaRcPS4xDz54Kfewq/0M9b+7hlVLRPPQU72gQ/2Gosu7oOdTuT
 8/t5P3zRQzSIUmfAhSvV4EpDZatCf9motMYRo2wv7ZfhtLJXGfkSAqkS0RMvVYlFLTT4x3VSGmA
 bS5YKLYjwKQ8GrdcBUfniUoXXgEr4cKnbbBtNG9tv49EIQxKXZ12ubfdQNcJ5jWYBAja7cyF67h
 F8CqtdyJG6NTm7Qk2wQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290080
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11847-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:corbet@lwn.net,m:thara.gopinath@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:quic_utiwari@quicinc.com,m:mdalam@qti.qualcomm.com,m:lumag@kernel.org,m:mani@kernel.org,m:stephan.gerhold@linaro.org,m:andersson@kernel.org,m:peter.ujfalusi@gmail.com,m:michal.simek@amd.com,m:Frank.Li@kernel.org,m:agross@codeaurora.org,m:neil.armstrong@linaro.org,m:dmaengine@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:brgl@kernel.org,m:bartosz.golaszewski@linaro.org,m:bartosz.golaszewski@oss.qualcomm.com,m:tharagopinath@gmail.com,m:peterujfalusi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email,linaro.org:email,vger.kernel.org:from_smtp];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: D18E96D8B3A

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

It's unclear what the purpose of this field is. It has been here since
the initial commit but without any explanation. The driver works fine
without it. We still keep allocating more space in the result buffer, we
just don't need to store its address. While at it: move the
QCE_IGNORE_BUF_SZ definition into dma.c as it's not used outside of this
compilation unit.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/dma.c | 4 ++--
 drivers/crypto/qce/dma.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 7ec9d72fd690fb17e03ade7efe3cc522fb47e1ac..d1daa229361aa74da5d3d7bfe1bc8ab189761e38 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -9,6 +9,8 @@
 
 #include "dma.h"
 
+#define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
+
 static void qce_dma_release(void *data)
 {
 	struct qce_dma_data *dma = data;
@@ -43,8 +45,6 @@ int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma)
 		goto error_nomem;
 	}
 
-	dma->ignore_buf = dma->result_buf + QCE_RESULT_BUF_SZ;
-
 	return devm_add_action_or_reset(dev, qce_dma_release, dma);
 
 error_nomem:
diff --git a/drivers/crypto/qce/dma.h b/drivers/crypto/qce/dma.h
index 31629185000e12242fa07c2cc08b95fcbd5d4b8c..fc337c435cd14917bdfb99febcf9119275afdeba 100644
--- a/drivers/crypto/qce/dma.h
+++ b/drivers/crypto/qce/dma.h
@@ -23,7 +23,6 @@ struct qce_result_dump {
 	u32 status2;
 };
 
-#define QCE_IGNORE_BUF_SZ	(2 * QCE_BAM_BURST_SIZE)
 #define QCE_RESULT_BUF_SZ	\
 		ALIGN(sizeof(struct qce_result_dump), QCE_BAM_BURST_SIZE)
 
@@ -31,7 +30,6 @@ struct qce_dma_data {
 	struct dma_chan *txchan;
 	struct dma_chan *rxchan;
 	struct qce_result_dump *result_buf;
-	void *ignore_buf;
 };
 
 int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma);

-- 
2.47.3


