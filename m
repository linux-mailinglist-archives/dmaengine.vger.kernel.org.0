Return-Path: <dmaengine+bounces-9603-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHOYBbRgwWmaSgQAu9opvQ
	(envelope-from <dmaengine+bounces-9603-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 16:48:04 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B9E2F6EF3
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 16:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D2C1317211E
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 15:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FD93C342A;
	Mon, 23 Mar 2026 15:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T9R3FVGJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jM+x4WYz"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4593C2792
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279059; cv=none; b=GeWzWsaUMNZ0oezSIRyD7Xorn/Up+JbRy1qMFaeKm6bP0v1oVpW8LUJCvvOH+mUbllX6zeh7iV05YGRE5YQiYrSd2ZCj2Mxy3odwoL3CwhgiqtOoJ5A0Paq/DV9l0j7Z+WRbDy02kEwdlm1bYhG4mpB7AoY8HtSyYMSJBK3Wevs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279059; c=relaxed/simple;
	bh=aFvWQ0r/9MeZDMiHp0RHPM2rE3l+aKHR+uxUux2PIyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NusQxE3tzFYU7moUMfZzNzVzNQ4/lqek2Hu+XGgxmXcvLYbEd4FLOapGP/+dIdwRUW3rvlmonvS1t1LKW4eDlj3mnXbEWMmFn0LpwY1cXNRg7NktD0HoXJ5yOmF9dSR+th/KoRMQUB2KTV68SXC0NhcFO4jD+vNPo1fv/9Plzzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T9R3FVGJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jM+x4WYz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NFGniE2829289
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j+gmvqmnx6Mc+rqdGbk0x4TnThgU7BC6K13sY2POFME=; b=T9R3FVGJeYxH+WDf
	k+wVIYLnBU+nW37JiurvOG2sU9ZbDmmnw1RwdhlJaPnWPoanEe61bGuVlklEXDJG
	m8gugoWN032IjSqcJ83sCvalMeZpUJ4B+VoDjdNY3iahfVR3ofL0X1Pth3Sq83xP
	aY7OD6JXt34TWOEIChgkUidsnTjllSlkVWTsGmhD8VsOz4i9hBHaQLbho8yc8A+d
	eQwEZo++j75JZncb0dPlPLDQ4MqY4k1902BNdgJYugGBA7ROZ7o2KfTRC6zxG3ok
	jwCkPHGMKDf7/+vGJjRvy5Dc8MtP8AxsEPdJ75URA1TcvKkb9KShob21ZC6AqPJX
	KssCQg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d35r20jut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:17:37 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-602b00b68fcso157834137.3
        for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 08:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774279057; x=1774883857; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+gmvqmnx6Mc+rqdGbk0x4TnThgU7BC6K13sY2POFME=;
        b=jM+x4WYzMNYEqGoQQ9iHxzqFPVDKVlib3iNKAEU9uUVw0J5dJ0WdkYfdHFj8SVGd+D
         Met9E1pPZu/xRu7fxWmMwVn02SUilueVV1QDC/QXs4saCc08zHDymRCIUZYuYwMwcqr9
         IekC6+MfQqH+Mqf4gPy5WRWBLklEzoCksP5JNDqaUySk4pNB6F3dgCoq0iURGeKBawv0
         NUAFHy4nITsxlAJVVb2VLf1l4PiXkhG5n/p2GEky32u/0v2U2WRwpFLl5Msekm236GWq
         JVcdEbCXxEoNsDLFyIbLNnDz9w6ffKOb+l+f+PycOegLxnxLyacorL0lRX2o+JXeBDTC
         nJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774279057; x=1774883857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j+gmvqmnx6Mc+rqdGbk0x4TnThgU7BC6K13sY2POFME=;
        b=QyaWY4XZcROa1f2y0eLqyEbHokYbkXacz3Bq6lQ+1WebYsn/Av5V1Ll6t81flFeeyL
         S1el/LqzdvdgRs3/8SVRbiBzprXunHvGEVSiHV5+56yZG00Ji3AArdZXgOr2bVt1cteB
         wfH8MdkEgS4tXy6AOJIJPg8098IBW5N6ygYce+i3SSHTiinqDBZWnH8j5iKvsdjJ7ci5
         iE199oDlVnclZJ+IsB69lJzwAfbr1TFb/HhSFovywUV9t8kg8jCzKxX8RRJgYe6hy4vf
         gHLF8zMBnz6phFC0CsKgLTJDFJWE72zHWu271oPrgRPSFbdQAEZBEwMvO83A8oDoe7ps
         KFtg==
X-Gm-Message-State: AOJu0YzwMmN0wPKrrBvhqxkqin2k/ZsN+6n0UhctWMlmJD/7punGHotZ
	DclqIXAW8BwviOvGV3CHA0nJIEYee31ZXFqjelIJHOigZbN7Grun/lh7JDtw0NrzUis+Ut4RacL
	HYzqW/OrAScgyA3D9ZiWMCzke9crpRnuclRR5A36xgJBFpRj0yDh9CPv2bPCVmOw=
X-Gm-Gg: ATEYQzwmRWa4dvsh96h6IzNSRbmIU9A6ohoC2rhqIFv1V2lZErMMhu7QXXOukPCj3qO
	A5Edlp2vgYbjgmcNvrvblNMkZHRq/afeHVpiXyiQgo63gQuBn4nCAh36Yaz0Jj4vKAyeinacAlQ
	GEyICPROrAZqmxQNx4Imql5jFUY6lsdsrHK40xKAPvn/U68bfUFxoV4YL0C4kggcSCbI7+DPJMf
	yMfTt1Pf0QSNMUEU9Mywgwz4Mffx12hS6Hu5K/1eqVE6cnKfUWOMhjPYRXfXAxiMcLwgKX0rOIT
	tDPfzjU+TV7J6xIRGAw9cUXKleY5tAHvgW6281oUOzqT1vHQTfpGlrRAFfEmnPho6dH+s/4FuGE
	Y8wUNR2aJ3nzhX2Eyr5jyYjY88Mx7tZwkO8uGhYzuD48Y3q+dBmbL
X-Received: by 2002:a05:6102:9d4:b0:601:f3b6:f2ce with SMTP id ada2fe7eead31-602aeb2d448mr5250265137.12.1774279056699;
        Mon, 23 Mar 2026 08:17:36 -0700 (PDT)
X-Received: by 2002:a05:6102:9d4:b0:601:f3b6:f2ce with SMTP id ada2fe7eead31-602aeb2d448mr5250225137.12.1774279056228;
        Mon, 23 Mar 2026 08:17:36 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:f9a0:d7e2:7eb6:79b5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bd923sm35936993f8f.12.2026.03.23.08.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 08:17:35 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 16:17:10 +0100
Subject: [PATCH v14 04/12] dmaengine: qcom: bam_dma: Add
 pipe_lock_supported flag support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-qcom-qce-cmd-descr-v14-4-f323af411274@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1476;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=EVDb1irXK/80h7Y6DY4Kfs/+E6/12M9d/9hBrF4TLTs=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpwVl9Npd4BfJQE6nZLxYtQvLGIHKZHwz2FunND
 cHrNbKAVnSJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCacFZfQAKCRAFnS7L/zaE
 w77eD/9bpkNJbRvyTLKxP7HkoX7qTXeuM9tjzrmiWidf56T7Uz/rYooPE0pf0RjcpLgvdT504P6
 9q/LInm16xT6358vUaDwpLlmi7yBxMJkAqdy+orCCAZn35tTPTrDQ+j3QzfssSyw4j+xSZB31IE
 Ej1ulK9sMQcKe4ijDAsxnir0bboum85zrPbtuYLxLUBHdPio4KaJ/T5JITA30MAyoTzfE20BqFp
 nz4GdWkfYqGCE6g+QgJvXQvcQelcvoRPwTTl0pfsEKFzY8j3DsW431Jny1QhR9bad7IIGECL2FH
 TMnKMCN2D3ORNtC7VK6rG4uoTl5XIMh6xG2H5knaDQHX71cy2EvJ+A6raxjrmPDQwbwnfVg/yf1
 JNo0nIpnDqTRWg/nHcHPa8mZo5dPzL4RwocpoToAEoVnzPzPCuL/fBakBo4Woo+IZIolNQZV+ET
 c/b9cpOyFZjsfjCSA91TEzc4K9H1vKJ1cefAIZofu6ALdq2OOOMZi9fYv1gU25LqnbTIhAupVX8
 opfT6v0vKoT6BwyLLc3xjBBEZB24RgdgquU0bL1ivqdzAJMqdVfTwHJMmZT0T6dL6v4bxFaQTT3
 +BhXyJ7fTrJvxeRYckX/j5NWDTB6goe0cNwCvDdg/YdWlVGVxVBB7KH7/8wl10zc0AB44tU0Qg8
 kN7EjEuUz4vb5VQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=VvUuwu2n c=1 sm=1 tr=0 ts=69c15991 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=ZSnkYuKn9ZpO9KHknGoA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 7v7aEIBxFokBFcCd9dtTxew1akpU8nBZ
X-Proofpoint-ORIG-GUID: 7v7aEIBxFokBFcCd9dtTxew1akpU8nBZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExOCBTYWx0ZWRfX9AGoXWb/P+Zn
 3709bmalra6MuzSh45Q9ynEbprEpkgPDErrrh0CNoma/2Mn58GWOBHjl5NBM2f/bL1RDMyKxz1e
 oVRbSHSc6wT256lVZV85AdowHDdrPMpjFZ1GZl0uXrB6z4z+TK7O2U6SfRUsDmqjNKD0SS/+itz
 uleC6Lflg7FCRn0B88HqqzlkamwutfJ2lcCexluqP0SQY83mkqC54CE7CaAepAKmVkKN075BMoH
 KFXtXXT7xHCrZcH1YCaK+QcYe3r7DMwa3qffKBWROmInKqTDUotjICqMGoK9OyiTqcc1DkH0FMm
 NACNZOC2gAFmG+inxJbIy2vPUv+/x9wERghiZgdscHDpotJZvYEvajDnNMfWEUx9nlIgssF9lOj
 5iB68AOkJ9N46cEuuTlq3G4UOdsc4HvGQmLUts5B+GSjWS98Xg353G5KAh9Ktti2jIu36lNVwiZ
 +jESzTLfFA4oyvBXzFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230118
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9603-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,linaro.org:email];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: A8B9E2F6EF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Extend the device match data with a flag indicating whether the IP
supports the BAM lock/unlock feature. Set it to true on BAM IP versions
1.4.0 and above.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/dma/qcom/bam_dma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 8f6d03f6c673b57ed13aeca6c8331c71596d077b..83491e7c2f17d8c9d12a1a055baea7e3a0a75a53 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -115,6 +115,7 @@ struct reg_offset_data {
 
 struct bam_device_data {
 	const struct reg_offset_data *reg_info;
+	bool pipe_lock_supported;
 };
 
 static const struct reg_offset_data bam_v1_3_reg_info[] = {
@@ -181,6 +182,7 @@ static const struct reg_offset_data bam_v1_4_reg_info[] = {
 
 static const struct bam_device_data bam_v1_4_data = {
 	.reg_info = bam_v1_4_reg_info,
+	.pipe_lock_supported = true,
 };
 
 static const struct reg_offset_data bam_v1_7_reg_info[] = {
@@ -214,6 +216,7 @@ static const struct reg_offset_data bam_v1_7_reg_info[] = {
 
 static const struct bam_device_data bam_v1_7_data = {
 	.reg_info = bam_v1_7_reg_info,
+	.pipe_lock_supported = true,
 };
 
 /* BAM CTRL */

-- 
2.47.3


