Return-Path: <dmaengine+bounces-10852-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPgeGRYWFGo4JgcAu9opvQ
	(envelope-from <dmaengine+bounces-10852-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 11:27:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B82C65C8919
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 11:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2CB73006975
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 09:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EC13E5EC1;
	Mon, 25 May 2026 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mmOJRszz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gvEUM4wb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608A93DEAC2
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779701266; cv=none; b=nNUoPSvH8+X9ma6a+xRuigpT1S/3IYZcu6di2jgZh/fRAkMfg5QfiLoadboSIu5FCpbDEycyDaBczL3X4E3kMgtc9dXzQCt11zJDPvyUHQvT4uuk27nTgELxQaHvAItGh1UeKsslTgDOjRF2cS93hqXfxh/fDidCpZMN3otcjQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779701266; c=relaxed/simple;
	bh=mb83qbbxTmGxdL5OR5cWgWlR5gSfuaef+L9b3Ihqdd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIS27ldi+iVglHqO/3GPozkXe2UsZIAaJC4XNCE8Y+8D/3wYNKpMvcqbgZJDGkEulSsy6A2+TuSFPlqlxHgKbiJCCTIANseeDAiELbkoSOZl3WuW5HoK0xB0kU5fjirbOmbzYLjhzfBDjbNeXWYO+W8NkObnQpBGPDKHKROnr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mmOJRszz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gvEUM4wb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P7QOmW3063427
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 09:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=x2UemusCsMVtYZL72zrXHcNp
	cJp6eLVEC6vKKsQ8QBo=; b=mmOJRszzSuMpo7ZhjzQDWwbvTKpTkIkycy39pmpP
	ipxraPadlmA2unYtt0f33C85tZXcowA5qSXv79/iNfgy0ddZmEp5sdrkHTwvVPiM
	jDMb4hDV1kfVeGyIO7H/txARoku2Xu3WS9lZaZlaeI+atQOlIXrsBYN8LjBaXF7q
	x4yCz5EwOgOkZHhbD+lMipY7Tq86vxK2y0tlXpILRjj0QiCjo6jUg8H5Um2fXZ6P
	mn0rl9f3EXINXE5QDwyE/fAZpwudnDFnuWz0UAHZYEEGNMDe6NAahoBFtkGRFFnt
	ujacOxGq8gYxujTfPrcjRQMqLVy7YLeKEki+WF/QBrVUIQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecj1ggfyv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 09:27:44 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6314d30fcd2so2398416137.3
        for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 02:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779701263; x=1780306063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x2UemusCsMVtYZL72zrXHcNpcJp6eLVEC6vKKsQ8QBo=;
        b=gvEUM4wb43wIK0qiMlM0C0417PtzJSiNdFSnUPVUkgGTc0qG6tdNB3/69ilwa+x9o3
         1ciDjkcdGPceLQVDMz3juhZZPmsLEhtGqMxFBHExbLfiLG4nT+lFluV+rZ2I3Z5Eeupf
         D7MdWfC3nTKBwG+5w6YbZAgG7Wb0s+hgFfxNPsDJHoBh9Gie5hIrR2umeZdJw/olN3lG
         OjVDCEPz2rqF+c7jGaNYBKVE1w5XbGj7dp7GgWXsdKhmggrc//O1375k3MlTRV5tQiqv
         DKQAWSYU0z2ETub5dKgfFhGgObLSOJtP/0Ld5Jpv57jTPDRocoFOOZn9koixltXGOTDQ
         +Omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779701263; x=1780306063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2UemusCsMVtYZL72zrXHcNpcJp6eLVEC6vKKsQ8QBo=;
        b=jjjTmUGohKVCyNk38RFg8mERl0/XZ6kRe0p0OzCq367doxIG57AkAWMcHNLIowhnZl
         hcy1qkOp80A3MrS+xR7rZsgcVmYxx2RpOF+Lne6NBxsHgtgI59q90GT9eeJBL1oHNuCq
         d/Hf4VPLhOCsW5fveiUpLrDfF+GtOS027u7bc1q0JHbAAi9RudPVjkeQ6wprwBacrA8w
         xzgFQQlJC4CxJuFIAZCW3N2FvBXhNKBdND73WWD9n9TbQ60gcY7UJXB00nUH+99jy1cH
         kXeNXU1lgEEHnd0F8nlkXuoyp3KyexDU66e5yDUGu3i6ChpvJa8nm6QBHfhAikZ+aXvA
         iI3A==
X-Forwarded-Encrypted: i=1; AFNElJ/qPaAbsjozAoOD0UAg2PdxaBt5HtHxUwJemocI7cpNZfirjb6LK5VN74wioJciMo03SQTBq2PQQek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1IdT484nZKd0gNMFoWbDhOQGhkMaPX85w5hFPMOaWr7m9ESyW
	v3w66AnoOC29gCMoSuxlbmW7FONQU9oTgYnDdQ49NKT8IEmOCjhDmHKmsDeBpLZS+3UvWVT37P0
	VYYsenqgU7NPrSWnzIRYUnccUtiukAoDdZy/h0EI0me+8d9cptm3WwSVduq523GY=
X-Gm-Gg: Acq92OF9V9zq3uuAlHWaIqcP5QnyoBzJpiwIivYGKd4WZeoPtc/HK4wZJjmFV6tKu5x
	LjYAgpfNvOsVv6aRRYKUhkgxH6wGrMVu7vbVsICH+u0t0tin1vmy9eYCjxLSTModfI46k7cqkg2
	DYWTAvTBTPsq3uwiNTez5PHSt4HYGm8YXQTuLle69xyaEC5yazPsf3ypm4jJmHgUcQqJS5kxU2E
	G4rkU4ws4zPIXK4g47GJyTTOom7oejMUUPblS1ZEamrXeu+eLTi1ZzJBqVRal2jzH3IM1qmc1oq
	5hFpiwiKgKqOsqqMvcPvpDuBpV8J+dBWghTMDZ6vmA1992am+8QJWmFDmL5rLXSvccqS6zYHczZ
	Cb3PJckoXG30KXPtAncvJRnJNup9UeLg82RzqRiHwmO82TRuD8/ls9+XTaY9trIij0gIvGK9zl6
	6CBZYZtrHxiW8ij0o/aH59M62U6lk+0NE4hMNfhrORi9F+MQ==
X-Received: by 2002:a05:6102:809f:b0:62e:c54:fccb with SMTP id ada2fe7eead31-67c85c33d2emr6532619137.28.1779701263301;
        Mon, 25 May 2026 02:27:43 -0700 (PDT)
X-Received: by 2002:a05:6102:809f:b0:62e:c54:fccb with SMTP id ada2fe7eead31-67c85c33d2emr6532596137.28.1779701262751;
        Mon, 25 May 2026 02:27:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32cb37a7sm2564336e87.2.2026.05.25.02.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 02:27:41 -0700 (PDT)
Date: Mon, 25 May 2026 12:27:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Subject: Re: [PATCH 09/16] arm64: dts: qcom: shikra: Add CDSP, LPAICP, MPSS
 remoteproc PAS nodes
Message-ID: <4guumv7ve7rshw2pjvumenopxsefha7hvj26tw2pgayz24ytxk@iry6qyqqqs74>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-9-f51a9838dbaa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525-shikra-dt-m1-v1-9-f51a9838dbaa@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: in6u6A4oMKlsAHLDxFlzLd5elw1e3tkZ
X-Proofpoint-GUID: in6u6A4oMKlsAHLDxFlzLd5elw1e3tkZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA5NiBTYWx0ZWRfX1xVpKClbEqfX
 zIJdoYtIfWNOzBIztIasTeBzwNc3PQrqqdyVNwjHl5lUoG0wHMl7RzRrDcIqkl4W1VMTfynen+r
 tOueOGWNZV/aRERndxXCHC0qUXVTvOob8q7IgcaV/JCjZ3RHgPZt5C4CMLH8Pv7LuFxEslM7KnG
 XLhCHmQ147fkyy5lzG1UhDvxOpFqPd5c9M3w7P2iymNSG5bWI5mhiM+g7kDgJ5XqpNoZZFGcNQT
 XTyDYReAU4hW8/nIMDcBLZ+cY9uukJWgNrpx9wYox+xJdoD9leCrBQcp72rlyInP1VOQ82xgeE9
 vTnHHU94lHjaaZvFOe8PX2997ycDYN73kGcQU2DVfuGvumNjE3/LzwLmuKBXKANWlXHDiu0wXbP
 W5pqskeA0TYhmRMk+jwQRLYDBJliqqnBz2M45ncaeeXisTz13Cclacuv71eiu7hpHGYyEcrMyTX
 qSCwa/qDpwqlJlX9UhA==
X-Authority-Analysis: v=2.4 cv=D8F37PRj c=1 sm=1 tr=0 ts=6a141610 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=6L8jDZTAue_LqfRzy1MA:9 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250096
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10852-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,c11e000:email,b800000:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B82C65C8919
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 01:19:13AM +0530, Komal Bajaj wrote:
> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> 
> Add nodes for remoteproc PAS loader for CDSP, LPAICP, MPSS subsystem.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 164 +++++++++++++++++++++++++++++++++++
>  1 file changed, 164 insertions(+)
> 
> +
> +		remoteproc_lpaicp: remoteproc@b800000 {
> +			compatible = "qcom,shikra-lpaicp-pas";
> +			reg = <0x0 0x0b800000 0x0 0x200000>;
> +
> +			interrupts-extended = <&intc GIC_SPI 257 IRQ_TYPE_EDGE_RISING 0>,
> +					      <&lmcu_smp2p_in 0 IRQ_TYPE_NONE>,
> +					      <&lmcu_smp2p_in 1 IRQ_TYPE_NONE>,
> +					      <&lmcu_smp2p_in 2 IRQ_TYPE_NONE>,
> +					      <&lmcu_smp2p_in 3 IRQ_TYPE_NONE>;
> +
> +			interrupt-names = "wdog",
> +					  "fatal",
> +					  "ready",
> +					  "handover",
> +					  "stop-ack";
> +
> +			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
> +			clock-names = "xo";
> +
> +			memory-region = <&lmcu_mem &lmcu_dtb_mem>;
> +
> +			qcom,smem-states = <&lmcu_smp2p_out 0>;
> +			qcom,smem-state-names = "stop";
> +
> +			status = "disabled";
> +
> +			glink-edge {
> +				interrupts = <GIC_SPI 286 IRQ_TYPE_EDGE_RISING 0>;
> +				mboxes = <&apcs_glb 9>;
> +				qcom,remote-pid = <26>;
> +				label = "lpaicp";

No FastRPC for LPAICP?

> +			};
> +		};
> +
>  		sram@c11e000 {
>  			compatible = "qcom,shikra-imem", "mmio-sram";
>  			reg = <0x0 0x0c11e000 0x0 0x1000>;
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

