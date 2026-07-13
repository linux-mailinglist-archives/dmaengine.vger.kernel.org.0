Return-Path: <dmaengine+bounces-12386-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lzwvBzrkVGpxggAAu9opvQ
	(envelope-from <dmaengine+bounces-12386-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:12:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6295874B5F8
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:12:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=YqmcbfQW;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=XJHYsRUJ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12386-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12386-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25D7E34A9D8E
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 13:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08B5421F05;
	Mon, 13 Jul 2026 13:02:03 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9563422529
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:02:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947723; cv=none; b=npF2/S4QEZVRQfdoZctTe/OL9DlIP5Iek12chw0z7js7GD2SSDDCPGyLXVGo8aGC1cgGIqY91peUHq6X97RtGgQhHl+3TIyyF6fnfy2E+jm9Qv6qsX4uxXmlkhusz4CACERqr+AaLwjuEkWJSIu0EIzuAkqp1At/kHA3eMnsCFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947723; c=relaxed/simple;
	bh=/3Q5BLE2qswUURgRMp8Md6+CmS+GMHS0PuiKEz36BBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gUWW6L2zjIUHSVjYrb2+fFR93Y12C0wR7CgeSTydqpJ8vPAT/nS8+nUYCieYhC/Vbxth6NL4gG4eTTeetU60dx+vbt1r3OfIWGJZKPXBAxY+LcLI4G5Up4MYVab1C7NUPx52fbfjZ2FCkjVM1gm5a6/6ISOp/70spKm1bRLvnI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YqmcbfQW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XJHYsRUJ; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCE7J21210730
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I65WEZ9oqgYF8KlnrmzqEJMBV2oN2r3NUJBwbhZLtgQ=; b=YqmcbfQWyFimoHqy
	hTBs1MZbNm3SnxRLjRNQ/3iGwHDx7cdV6hRdap6aJLHbCp0KnDZTWain2cD/yTH7
	6c+jmCNZ/lI+ReAH4xtBGzF19kJzM01ws3kYh1iQ9St5Cbj5GnQatB6pjhrZNxXc
	gzDCmV/Ph3lBZsLerwrUsTkdlGELQeu7nHQNIgeg5fo/XjCvz54VAfBPeOBcc7ps
	qvoAFnR07kKU+JNSI1eZw7ScSD3DxYtAcPw6U0URd2t7rlNulhBQOtYQ9dinfpOQ
	BKhzUUWld1vqgfVhlvup/eVKzFJnES/jgk6Sin5kmHS77bepwnnjbkYLNuhMG4KZ
	+ftuLg==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcw4qrtf6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:02:00 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e9ee20bde0so2171081a34.2
        for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 06:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783947720; x=1784552520; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I65WEZ9oqgYF8KlnrmzqEJMBV2oN2r3NUJBwbhZLtgQ=;
        b=XJHYsRUJ7jxmK2mWmFI2oPqJXxLmIWgBRiHlYVNsUzMXyfMvk9D4tTbknl0IlN1fRk
         AgJ6b5yexjtnwrpeLF3kivyyasX2kkQQPgyLRmIZqgLjrt6tB/gHTMf9bfOBxlsntigP
         +EDclRHaKKzdiUSeNWy0sC+XqDCVALKYkXSOUFWjsPBAx0uUfuWa3SKeY23Hy8DIc2+O
         Bxa7RYPFI1bnSGQ7PTS7nLa0sGMO4UMEaqiwwI6/Mv7EMmo6QaROR7UTvETyHXQ+MVUx
         4V5yMd6m3rMNyRtGxcpKUkrYuvdi3Ch+cMKcKwwnfUkpDB++GMnzIYHyeYBNE1ZuTHoK
         Yp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783947720; x=1784552520;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I65WEZ9oqgYF8KlnrmzqEJMBV2oN2r3NUJBwbhZLtgQ=;
        b=rTn9YkJQh3IOVw7NdlCVHLZKcmEom55NnEhElejNLIRO0rcm99ZdRZLqNwYnfUC8+6
         +Droz1AK3pa1NxZcXAVILXrIPK/HZOr6+p+4hgKQpfdI9rZRBdnDHIxtGtAPneRkbfOh
         HsjC2MQPhGJpFt7nJsFpgn51zZot9R32/O4BVXfsCfU0HrOLt/x27l+r+SZKhnuA8o6H
         T7J+Ownls3p+gUptAg8B4Z46WCqCwblW/IMIU+9G1O4tccx+U2IxfRXSnjBJljZyAFTI
         J8Jwjfq1kgANHzedT1CsPQLj2viHw2unLGmnzdaFR4gd/QkzT97BcBcEAcFL2yhoG4P4
         p02g==
X-Gm-Message-State: AOJu0YydlAjJLZ5zNrlu4R4DGdYRltKU08mkNHM+YaV3+bFD8AMTCCal
	Pz0kktiwhIineKWm1MZfzbcSfD5nk44bwFl34ZltAwQXvWecd8yNutmaBS7etGPZ+4+v8bO8Rot
	8CAZL36PxHXP6+aGKxd0yRjQu6Xn3AxJjS9nzeqn1y1aGgnKXcMJx+xshZsLUoi8=
X-Gm-Gg: AfdE7cnsctS4JcrJ1+n8WD7woVbNmsOAmJFoyxrRSmKd8XNRniJ9QNAiL69z8GEokmE
	paWg8oV1RdmQUiUNHX9RMxJjCfM97CtapzRE+d+1lLVa2k0f6M1kRwmrzoK2R7pVFlP/Z3ZU5pz
	szqUzA07KKvwKi4ukCntoi95iXjpbFX5p58S7AsjObg8vYkymQ62mQu5sHl56KdHENyPB5TLNi/
	n2VO1lPP3SHPULPVL7DEonDzaK5VZezvamONh1L55kOJTdlwivEATyr+OXRTtJVnsL1c1bdmTJx
	WUa6EOdsYrSax6UVVGUREXNfVc84lPP/39OIJhEHZ9KRud3z+7YBKmYfRmqz98sbu1PBQ5nTdv7
	gCdHSSNDGNo1IXhNdIiPXKj2pz85VKo11QKfGnpTX
X-Received: by 2002:a05:6820:2220:b0:6a3:2de8:797a with SMTP id 006d021491bc7-6a39a55bfa3mr5264854eaf.11.1783947719699;
        Mon, 13 Jul 2026 06:01:59 -0700 (PDT)
X-Received: by 2002:a05:6820:2220:b0:6a3:2de8:797a with SMTP id 006d021491bc7-6a39a55bfa3mr5264804eaf.11.1783947718791;
        Mon, 13 Jul 2026 06:01:58 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8881:83b8:89fa:1a2a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2d97527sm306129725e9.2.2026.07.13.06.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:01:56 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:01:11 +0200
Subject: [PATCH v21 10/14] crypto: qce - Simplify arguments of
 devm_qce_dma_request()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-qcom-qce-cmd-descr-v21-10-bc2583e18475@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2674;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=34ButmP/zHfg7ujor83QeeFN6rzFB4sOTC9ae7ymGro=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqVOGfuyASyenMkoXWOhJgZ00qytHI++2nO2fsz
 8TkfCIEhOqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCalThnwAKCRAFnS7L/zaE
 w33VD/4rDhltcSAEuGqwmCDJE+p6NI3I7To90AxBT9EjTdXDOmQAXXyyoRUCS7QE2RaoZhWaYLa
 nrvWzWyLMm6SuZi36hJjvs4a1X5cxgUzc39f/m16shf7v9PmFTtg4WWrtEyg7u9sxtw7r14WKdo
 Q+M5H3YlRG0TvrVH3IDdBaue7HxeJ4lgGNhH3bRdSZnlvlU0KhZyq49gZjVQOsiiCt9jvbh6ZRq
 2L4Y2+FQ/xMWhiOZA8kifB4l18XmoacEaVOis1e1CMF9OBPzp4mRicU+3OWhJkxZO+UuRLDOf5V
 tsuw1VuyXBYRuWqAwFD/B1G/jsDNi9pMQ98vJ2fFEpIHJN6sX2/DfczE09bNz6+3Y8oHXCjl9Gc
 pUwuC8LezSx3PGEswV/DFsmWs0USYxG0WTXDCLctElR45wnT7/hCSpN1cSOXEzrigDgNSmgraTT
 bVJUaydalw0ScF7XTLQXrO7JS+18IkOSEw3mpk3Q1apkddV1Mlr01gKdJknJBaN/3AIULDVfFX1
 4SN0oxTWYqHaL8k7iE1SD04j+x32Up/D13O0SC9ZWXOxGP09OIsVALrHAPw55l/Y0kGJwPcfR7I
 L+v3ZUxQsYa8GAct/qpNhql4ZEbX1Y4mut0n+N1UCfAGyOdTM/fVofa94puMrkopl2CPPPEKFdu
 QUVPNik9+ylXWIQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEzNSBTYWx0ZWRfX7OtIoUzb6FA9
 C5y//VLsNDiZgDCeYyC+xNg/406k3/6C1jBv6TF89tj9Gg0m0jQdbL5Niy/cfllKhJ4o//n5RON
 V7zEVILiVbvJiKSMljjpyjx3n2DYrY56qpIXc4vObPSDTiSNIO1DwMq6d/gBS5c1SjAz7UFijUz
 krJSlMU/w4jf7j+8C1Muj80LXjUlbKVqkSlWSNWmaRMR7HnPkPrvA8f2Hmqp53Dxv6c42xcKSCh
 fgP07bvgEaOFqMyVEqZ6PTKs4WLG299zXGEDWVWZVqKyyV8uvkEgNXyXVOSjXBMmD/47RJSIiNC
 AHwn7X7kqzOaQs9dYCx7KcaAm5fXb1MIsKei9RyVq5TVhqAc3z+zozHkQl1/S3kfIdgEotf1sq+
 gE9RtkgqAaX2VzqKZo703H/KmYKdU+L2QmDBB6gVu3thhnwUhDTfzfEsUpnAsfd8SJYQbcq/p91
 9JmjMKrq2Wfs5VbntcQ==
X-Authority-Analysis: v=2.4 cv=HJrz0Itv c=1 sm=1 tr=0 ts=6a54e1c8 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=KKAkSRfTAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lH6k5GM5CfRwGFUYfCYA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ZhU9L8vCNrVT8xmsDZY47lcHrvEGvxjI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEzNSBTYWx0ZWRfXyoC+YNNNPvZr
 NklBKK5/AWl/mmmm54VvmeQG32f0KpW9n+hU12d/eM6stBogQnpkFzubpBAuto/8xoKr5+nxTos
 0NvvOc+LNKCJdHj76tuvcc81uszRFJ4=
X-Proofpoint-ORIG-GUID: ZhU9L8vCNrVT8xmsDZY47lcHrvEGvxjI
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12386-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:corbet@lwn.net,m:thara.gopinath@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:quic_utiwari@quicinc.com,m:mdalam@qti.qualcomm.com,m:lumag@kernel.org,m:mani@kernel.org,m:stephan.gerhold@linaro.org,m:andersson@kernel.org,m:peter.ujfalusi@gmail.com,m:michal.simek@amd.com,m:Frank.Li@kernel.org,m:agross@codeaurora.org,m:neil.armstrong@linaro.org,m:dmaengine@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:brgl@kernel.org,m:bartosz.golaszewski@linaro.org,m:bartosz.golaszewski@oss.qualcomm.com,m:tharagopinath@gmail.com,m:peterujfalusi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 6295874B5F8

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
index dd860435d2c47a608c82cc2686583a44ff96c889..aa4a0b17749081f1ad653424bc265ee81e348e15 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -237,7 +237,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
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


