Return-Path: <dmaengine+bounces-11295-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +XGLOSWMJmo5YgIAu9opvQ
	(envelope-from <dmaengine+bounces-11295-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 11:32:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 568086549F7
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 11:32:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=XB0lkR6W;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="VSyoD+/+";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11295-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11295-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 880663044C2D
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 09:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3207C352028;
	Mon,  8 Jun 2026 09:25:58 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AF835E950
	for <dmaengine@vger.kernel.org>; Mon,  8 Jun 2026 09:25:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780910758; cv=none; b=VQ1PStXzcTQZJ2SjdHGFa1irXdA0jDapLxsvAfSVkvGGyU4t2x051L0KBvI/pWNqbqaZ5Lobj9sA/aWXSjo2zAjtGuHO2VeZyCI7VigsKnYJqq0jaT/cTDnA04SOe2k3yrPG6IqoJynmo6JyKoUfqVvPmMbuU4LyUdLvS4FdS8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780910758; c=relaxed/simple;
	bh=n+HxEF8s23krUqBRK2DhOq+YTzm8ThGv/OBjsqP9PQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUKWLgG+YfQ5YhjIFUxo5rWfcTVBK44kNLaZP+DiyfaRiX/JPY7TMAUrosIcDybuMVddxQYt0OZBuxl6xl0RarCvmxeHdr7WxAvJn8FcCpbu3jh6LvsRONcoFNJYsq2Ma91hNZkZpZpHKfIsmIDhzPlv7Mwn4kDcEAfAIBL4gWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XB0lkR6W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VSyoD+/+; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586Oen02385887
	for <dmaengine@vger.kernel.org>; Mon, 8 Jun 2026 09:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CgjJxa5tRylVDlpuu/EUPaaInG5XWGvclHINkZ9vI6M=; b=XB0lkR6Wis5juPTp
	ebZUfdPr0JCbFo8sapXxtVOHdJi7r23PrVoBPenSsSlpbsW0FYdXUjsKrusi2Lmh
	fMJMjtqJkqWYqLALG+udLcjRHmnyPBkqB/KSh8A5FsuUPU8aMpy1NX5aO9aKAbEd
	IwNpKdN5tE3I1QCEG6qSoeBrGHUbJgRAKnQxLIbHpIhfGH5ElqY49jogJf3u2QFN
	wLV+JXztl2xbdbJAK61+Aq9b+Fho6enQx1e0hle6oLPixWpItnsQjD4zmnxClcKt
	hFfH+UdYrWpEQeNLtIkj4x05j814aemhBHj+HFk+PQKsb0hVWx08Fnon2szDi4hL
	LgvMbw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcu8xvun-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 09:25:56 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-517796be724so7875191cf.3
        for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 02:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780910755; x=1781515555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CgjJxa5tRylVDlpuu/EUPaaInG5XWGvclHINkZ9vI6M=;
        b=VSyoD+/+SC42Gtq8xDmzCet7KXcW8sqSVgmN7XB9MHgQbFmBiIdhRPaCLef+6YJifM
         T6uEum1ocmCC33PE83aY1uNdVd4WBxbL5tIfvK9lOYvpz9Hn2rVGfoVUhqfoXZSMpAca
         l6YTxQ6bVT2yRamTOCIpa5e7fkcKzeluVX3KRJsk42tAhX7802SYSMkO+s+iWSchLWd2
         WABffPXDA+O/7UzI0e1FWPE0qkLqI6UvWu71isP8gwSHw2sxT+7rUV3FFiq6AvCUfUnP
         oxfaMR14w2ty4l1mDd0ySXRqgRJrPT6c6AKaSub2+DhTnh/Qy6kyHEJPNvYaOum9u63/
         7SwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780910755; x=1781515555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CgjJxa5tRylVDlpuu/EUPaaInG5XWGvclHINkZ9vI6M=;
        b=mfXX2fRIPZ/+betKVn42FpAclyZdD44NJobIfQ3jMpkKVGG9YHWuIbjoBCW3jrWBUw
         8Udd9XZ98zq2Mc3wPHE3pkBdFRyWrRrO5/0ezgbETOtR/O3aM/9wRDlG8QGTf2PZy/bo
         PfebeE3I9zK1bOWKb5cEIDVE4C5/E56WgV6rENHp5fx8ZKOoIozpL71wCR4780qW/nVh
         woYRvm9EfqixwR6/l8czigsjIGDhfZ8qdelZjqUf9ohe8QnyOn2JF14/s+8slReaPzVH
         HmwnLCxflCoixuvRrFJGVQ0ihYwnCJktXICrjuGDis9010cA3RZZDvJjmwomBMcykYAS
         d0bQ==
X-Forwarded-Encrypted: i=1; AFNElJ9QRWjXDrHncpX69ey0uVmSKt4lPvDdNGOaKgmZcDhpwcAC9tmfywhKtACIT5kdZ0kx6KPnRnS6xvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0VGUfLUlSP1h4wpIEnjmyBLUzEGLVvbNaRgBriatxgZ+kPBGC
	qBeHDkgSnudmEkFGBAqXhKOz7DfHvv/LM337JY5QHsw79Vt93LrjJyarTpkc5X++k3zXNLKwTN0
	s0q8WelXblhV5zD6hc+ScghFLwlXvm0utYuHsmozaeHPc679Rxes/6c9s6QV6mvU=
X-Gm-Gg: Acq92OHzxyuPbPeWLm6WPUZiy/u7kvtaTUHIqRkgIY9YvRv2uOAuH5VJPOxITbA6G8D
	fd1ws2/Zn6nxhfmbky+OwOIm9zoPk8Y5whE+FT8MikTz2AtMi7Zp8FbKh47I933dd1rpJlYpMic
	Mm6xeQsin3WkVAysD7XcokRuwCi0CR4X5IF4xPAbVb8udchzx67nuI6D7dbrXnQ28K8hM4CRWR2
	Rz+8L+RsKOMlIAxTVTXw9voLm6lJuOjYcqVCh9vFm9FB/P8OvR1ooTITm07/mu32bAJhTMsjcH1
	2nb/uuFl0XHlVP+ZpdcJUa5JrNpYqWG90Ppz2eJGKOyQyotzO4iFaSMElS4syMNuLVyiwSELMD9
	KglJDjGO65NuOOInlyqerHUL111xGxVq4GjO3w1r1nUb+EHswhhv4f9aD
X-Received: by 2002:ac8:59c8:0:b0:50b:2875:5782 with SMTP id d75a77b69052e-51795c56077mr125571151cf.6.1780910755469;
        Mon, 08 Jun 2026 02:25:55 -0700 (PDT)
X-Received: by 2002:ac8:59c8:0:b0:50b:2875:5782 with SMTP id d75a77b69052e-51795c56077mr125570981cf.6.1780910755043;
        Mon, 08 Jun 2026 02:25:55 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf055307ce3sm833303366b.43.2026.06.08.02.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 02:25:54 -0700 (PDT)
Message-ID: <46cc26c4-601e-4273-8c57-02b9d07e6826@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 11:25:51 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: qcom: gpi: set DMA_PRIVATE capability
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Kees Cook <kees@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260602070344.3707256-1-zhengxingda@iscas.ac.cn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260602070344.3707256-1-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 6bS9nmX7YA0vKxmwIIowYOrm1jNbZ2Wv
X-Authority-Analysis: v=2.4 cv=deGwG3Xe c=1 sm=1 tr=0 ts=6a268aa4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=CYxUhL7LI-M9hzDX5WgA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NyBTYWx0ZWRfXzzzX5RODG2qG
 MDJYnurAO2r2o7Gy2lvEN/5yvPsmCkGuucok7752HAQtgZjocP7ptS/cF1nW0H4+6v57gFHfttW
 5oxhFylAgrcnA0HdSA2cbXLLoxsEfBgb/7RnHIHdpQrC9I1exh2shzL1XEZF4a0r159yXmp92BN
 R0k2sH0Xhfejy11BaNiuJarEgN0u96kWymVq8BqSEM6CYjPi9mg4rM0EY3ENctOBnU8xvLFfBL6
 BnAzU0Zlc0xEjGRTTwEa97vOIdxcSlSFNVneevhtb0otXQivOgknD0tgdJxp2oXwPYrWZX1fXEJ
 OoKj0N86rw6AWeIKTcjNv5GAiU20e1O9HSIEUQcLw0obbwxun7cAlfl+jh2z/6KjucZYHwrIai6
 wl+qx45agAH9zJ6obgUvIoqXUd90Iy0OMtb8yP0nLtM0uifEA6LCXhXeH42SaxKa8VHn3eu46aL
 9VbwKXKj3Pc+twjJgew==
X-Proofpoint-GUID: 6bS9nmX7YA0vKxmwIIowYOrm1jNbZ2Wv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080087
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11295-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:zhengxingda@iscas.ac.cn,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:kees@kernel.org,m:krzk@kernel.org,m:quic_jseerapu@quicinc.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 568086549F7

On 6/2/26 9:03 AM, Icenowy Zheng wrote:
> The GPI DMA controller is only responsible for QUP peripherals, and
> cannot work as a general-purpose DMA accelerator.
> 
> Set DMA_PRIVATE capability for it.
> 
> This fixes error messages about GPI being shown when an async-tx
> consumer is loaded.
> 
> Fixes: 5d0c3533a19f ("dmaengine: qcom: Add GPI dma driver")
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

