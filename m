Return-Path: <dmaengine+bounces-11958-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jbNqKMdKRmqqNwsAu9opvQ
	(envelope-from <dmaengine+bounces-11958-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 13:25:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED036F6A9C
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 13:25:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="avGLBL/1";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=bCaiVTN+;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11958-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11958-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C431C3107BA8
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 10:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C883C9EC2;
	Thu,  2 Jul 2026 10:56:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D963C0621
	for <dmaengine@vger.kernel.org>; Thu,  2 Jul 2026 10:56:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989816; cv=none; b=WB+BIb1PiBR44FmFhKhbRwmSWxEr8oXTKbCuA6IgvMs89u5iH+GIPxazELppCycr/JUvg50kvGXALr/BNdeLBpryT6chRELCrTe9y7kGEiM6/fvTg1BudBQ5Y5QqRhaYHDdt3d+A3Vk7D6WrBL+hPC/67rDii0jYLAyY8nx6YJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989816; c=relaxed/simple;
	bh=3AY8KOyUUyqG7bvvPct26mdyF2ZJXyCQ44f2DHyTO0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=irabTa17/zFnP727LubeC0B+75cs9dC4X4lx+LphddHZjOdf2ukF3/KbBgjmJnzJaL1o3YpDRRVwYsL424dR7G0nf70DzLsZXgJc6qiHcGtI+fgv2aMPwPoraR5j+ZZZYoatvVSp0Nyl2/yHe8qs6j0YxbcNePhLt37MEaZziQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=avGLBL/1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bCaiVTN+; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6628RJGn3049594
	for <dmaengine@vger.kernel.org>; Thu, 2 Jul 2026 10:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hgxzcki5UyBbV4/pVuiRUjRfHm1oE4qpLL6wM16QHWg=; b=avGLBL/13aCEgnD/
	yX9H0oixMcRik2vEesKt6ceIaas1P3zCDg65zzZqjWNm5u4HILtuaCl/WedbQoLk
	LM9HtQXV8Vu5G2X+cePmKUIjqIaGcWtkEJCASIwjbkKyFGDgPmyPjrjp06ygFSVb
	paepII5OgZcj7/RPGk5GiQxTmz3SLOY3b+Ic9CgO+Hou7iuSU7IcbOoRgTUtN8Vh
	6l6L4Wq34FtxaITwB9YNTX8AromL80uC1X5DVxZn+7ygULCN8GIx6ZZhbXtwhkbE
	nc/xltO9bwud8onLjH2eofHKuyVUOetaZoIkKlbnFbjZduykN2lY3VzQGgl32lbY
	obzquQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5541vaqf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 10:56:52 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c07313be5so4078351cf.2
        for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 03:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782989812; x=1783594612; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hgxzcki5UyBbV4/pVuiRUjRfHm1oE4qpLL6wM16QHWg=;
        b=bCaiVTN+C83d3n2/R7ftMv+OBjskS9BYhRKQbWNAMAePXJs51quCQ7kthqwb9Ie+Zx
         n6Qu/lqppvbJQdN3fm6xuiULuNi3M2kFLuR0yTTdRaxBPN0RtcZFzzwZCgM/NVfn8pk2
         e9LCMLl4FjT9DhGkEocxXNW2l0/0xy8BCJU7IdEKbt96Zrr+30Or2l0pJDv6vg+fCIne
         EKEFgzkDkhvbXa+dYE1apbaxpg2CslTJgeDQQq/VzuQmNMAPa9QLK3Qo51xlHnZ5xJy7
         La8EQ8voaCT52X+GjX7gTDOEO2OrX/q2B7PNj8iP2+0AxjdlCekLPooyEckWTQA4BqiA
         fnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782989812; x=1783594612;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hgxzcki5UyBbV4/pVuiRUjRfHm1oE4qpLL6wM16QHWg=;
        b=WRlZtCCp6vEo8LPUPl6tSEva0Am87vapAa2mV15ASvb1IGZ0+sK1dTlwg4u/YnIrxK
         yVYp88V3puiq3dLMyqFtTj97YtwXVFyANJde171Cc+3fUGmJfkksWvehmuGiht7IYz5c
         cQpqz5gl5NOpweuomcKLHECZo9YLVcr7ux0AeX/PD/W207PneFcIKJuSW4R4CYX9Vc6y
         wT7eBQBtMlxdxUfpgF6+PONaE0A3vcGui3ulkk2pu73VSpRDHx1xncYFnRyqHOD1c8Dv
         guZZAEqcvIuqcdXsyFMeAwQsrePZbLq/8pYeuBrgK7dgvafqfp4GktTERptdQO3gk6kE
         qZsg==
X-Forwarded-Encrypted: i=1; AFNElJ+MFTl+ymz/gq4O1ZniOubg4HeZP/Df4ikEW9ioau61e7ohSmqBjGTYG+K8w8+f3kx1IGd8sshlIGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw86rLlNRXK30qYgvME9xKwjjKWlPZ/drFN1VGgDXaGUnBXiVfe
	PsYpyZTVdMeh6/QtiMuzzDhS5Me/qnypeCE+f/LPZaUyGp3tgc6YlF1Dq32Mh1kjdpuKHS3euSQ
	rD/KVCvr8hbP8GcwFYY2USxkvNC+8BMtMrwb4FoPcXcsKMm3yXivYzt4kQNQ+lyE=
X-Gm-Gg: AfdE7ckOi8aodA3cyzFjmq7mwyQ4NNDT0jTimAAbU1XCOD6DJNXFxV1l8PhRFRoCF4L
	Y7XxWHx2vs5vsTdcvQPMbncIUCA04Ges+j2s0LoCHe0h73bc76LlmqNJs1rqVLcn1Gy60KTFWuQ
	/lOM5Jic7CpKotMSY8btUVMSewdeufeK8Yn2gZlYieIC1clcllSNgNyrmeG4hb22yTWBVXEwA/P
	zdg0lKYo0DXjdoM9AipaFj/qA8zHbkebpPy7rh3NMvvGoW3c3P2sPPYFbEXh1ufNzidRjVbbTOP
	4G6zr6fwR2/3v3Rl6nULQCz+De/0VpcQjRPDWi4nQpHFhfDW4Lig9SLYaD8L6UdOIqC4NTmY55q
	gECgJJM1ACT0yDsdJ56sQDvs4hGwkehQwFkk=
X-Received: by 2002:a05:622a:58b:b0:51c:d8f:d77a with SMTP id d75a77b69052e-51c26a560f2mr45694161cf.1.1782989811852;
        Thu, 02 Jul 2026 03:56:51 -0700 (PDT)
X-Received: by 2002:a05:622a:58b:b0:51c:d8f:d77a with SMTP id d75a77b69052e-51c26a560f2mr45694001cf.1.1782989811437;
        Thu, 02 Jul 2026 03:56:51 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b62c2d37sm110052666b.42.2026.07.02.03.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 03:56:50 -0700 (PDT)
Message-ID: <be113bb4-3248-44a5-8fe6-5942ec60f75e@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 12:56:47 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/11] arm64: dts: qcom: shikra: Add SMP2P nodes
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>, Vinod Koul
 <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Vishnu Santhosh
 <vishnu.santhosh@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
 <20260702-shikra-dt-m1-v5-5-f911ac92720c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260702-shikra-dt-m1-v5-5-f911ac92720c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UyXA1BH0_9GYhM9hNEOWXA9Tsn1WjCbq
X-Proofpoint-ORIG-GUID: UyXA1BH0_9GYhM9hNEOWXA9Tsn1WjCbq
X-Authority-Analysis: v=2.4 cv=Xbm5Co55 c=1 sm=1 tr=0 ts=6a4643f4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=YUvwHg7a0UAiIoF5iVoA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDExMyBTYWx0ZWRfXym5S7PF1rW7g
 WZ7jDI5lLzrzf2NWOC6bxX9KLciY/EH3M5PNoJ5uUOaGsbioG7eLS4Kd8oFphYg2Z+Stw+hceYh
 sPmkvF8Vt8GUwy/+WgyiZvIxzSnbz3WwhDLA4ylqZJRaxEHJ5YRwtso33b2wn64IDoNGT+Fg067
 y2/l4PAArJPJAJBX6lY57e4FoNdnaNXiVqJbwMv9Z+4ZMELJIM+nTt6ZJ7UilU3L5clpXADSGmO
 t8oLFbEmWDJ8S/NJ6o1uNOWBC4l2MfrbTkRKs3UXQTSV7kApykYMUuryBqjhxk65rBX0OxR7iIt
 qWQ7uuLkbupqVFYRw5UM1FzXrgD/8LGW7KZSEzr0Xht/4dcEK3s9zx0FQ0TaMX92NOuIzTZ24eE
 AEsaKiWGzw7kuC2aByuNT/FD+OVx3XTwPXVRXqAMk/+/YACNhUcwv//Sv8UcvvOp+33QJoqQ6VN
 cdkOHtHtNLgywgr1zOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDExMyBTYWx0ZWRfX24FVrb2Eh0oY
 K55ccXsB3h5EV15RRDdQGK9hW5weVyqjW5OOZoT00Gdn7dzleqlKxFYoM/M7oMej0wLAXl47Waj
 wT/dd7R1MDiMtfU3ssqFBBxxbbX/5Zw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020113
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11958-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:komal.bajaj@oss.qualcomm.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:vishnu.santhosh@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0ED036F6A9C

On 7/2/26 11:50 AM, Komal Bajaj wrote:
> From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> 
> Add SMP2P nodes for the cdsp, modem and lmcu subsystems to enable
> inter-processor signalling for remoteproc state management.
> 
> Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

