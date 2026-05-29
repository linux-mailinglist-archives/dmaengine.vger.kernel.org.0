Return-Path: <dmaengine+bounces-11028-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ7aAzh2GWogwwgAu9opvQ
	(envelope-from <dmaengine+bounces-11028-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 13:19:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B27B6017D7
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 13:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B6E9301ABA5
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 11:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D533D0930;
	Fri, 29 May 2026 11:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DLwaQyR6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PlMNcrOX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08113D0938
	for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 11:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053462; cv=none; b=ot8Dpcuuo40sFuSg94FDmGJaPCRutL4OnUFT0oEh4qdysWyZ6+S0oOjF5F/4u048aHxMJ5Hdth8lUymIirb3Eqpy/HesItxDhiqyQRxs3VLUZGeS3jbmxHl6gUDf1wGQX7IFevYyyOsFfYmRDvZlNJllNLMvRfhYFplXnzMI7NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053462; c=relaxed/simple;
	bh=IBmlyDzfF8aWtyA/qYIJJU3gS/F62zvROpfr4+/L8dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTeCRLdkPLzui0LO9i92wsHT+IN/eTVSPKLrg0ZFeh1DJam502xIdoSww4XIoLBTK6eOlzb5NLcBIWGL9E3Q1BDLuWijaBsfC8flPy5wyVtUY0gK/DKbWgiZQ7T5dh0RT88RoXBVXWslMKpBu7kwS7f5MeCFZT+i2UFwR0uEvJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DLwaQyR6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PlMNcrOX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T6gLMm3252775
	for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 11:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QkmRn9TbcwNckCQs9FsSZUZ3
	HeV/NcF5t61EORQ7sJE=; b=DLwaQyR69nUcXelnPWKRnkTrx2e4E81OE7q/XE2i
	Mr83OaX5vhha+rI/Xm/Ks35OuebAFHtvnv+G4hjsisslRk/daKbPelLppc8v9Plk
	3kORx3HDRIKJx8Co7/vuvsscB5uTdJ3qQ9KZSZpylNG7hZAw7TjAzeqaaXJGngR+
	q4BpMjwH947CsfkVCRPL6ApXW1AHc4GegBcd0UX2Y3B4AM0EKGbBKtn/FmgHMcfV
	5KeZTZ9m6oevUletgbUFdxmxqJjpfX8WJ6M6W+E42FZiRorIklABnq+KUAP4P5mU
	HMMz1vM0DtGoEWMpxyPfre+UyK4hX7PFnIsEEb1iFVS7cA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eespn479x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 11:17:40 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-516cde13e8cso167417721cf.1
        for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 04:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780053459; x=1780658259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QkmRn9TbcwNckCQs9FsSZUZ3HeV/NcF5t61EORQ7sJE=;
        b=PlMNcrOX+2sEGA1fpwbRy8jo/JdPU1zhqitYDKD4wdIhTEKNwX0G2PZia86dgo3Hdx
         4EI5S0nzsYOWFIAudvluddCFjNXaHj/xnAa9gvfBKZUUqX43ky/+vWP8gzsIBdpF8D45
         pFxUVUdUgStoUUeooPCW7/eWqdc4a6J3NMuU01W6F8d+eofDbErFb4NbyUjuTB+eG9cf
         P3BRbccEEF4JUYOlc2iaeXE13D0FqSZnnL/AVrKLdInWT7f+4m2xZ6GltnzVJinnvHEz
         1fJ5gSDFKu5URipU/4abVdTRYod4xQRPqsRqRO+yf5RHwYDq7ijIH///+RwNtj6V9wRs
         CqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780053459; x=1780658259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkmRn9TbcwNckCQs9FsSZUZ3HeV/NcF5t61EORQ7sJE=;
        b=QivjrrgyvIlrTaf+vulJOnoDS1v0f9+7ecXogf30ON+J20atjFmAnOoow4+q3Can/S
         5D7niFTW3vTCRl1EWtYEtQ94ptROMCMi1CQRZfgFOdFMv1Vaq+fX4V1AsOcNvTEJdPGR
         bkxqb81KVRfFSixcGm5UXH+gPG9r8YQiVmnuJObkNF1Tgk+9fXWjlPA5HiMgLnm8Y4IE
         bifhS8L5LRd/BMei9537pZGbwQZJ904rjOlOh4VKkrZbv2N48J35elCLJhY/tDzf5pF/
         PycXrOzNyqjvaBQypWwj/6keOB8Hf4EutrdnGfrcxC/yqQVyHk+XCd25/L27rWxOqoVM
         a6oA==
X-Forwarded-Encrypted: i=1; AFNElJ8M685mJlvt9cUel5qlB7vJBKv+SqqjCn4NmTmgd/cNLAiHoU7AHhwJraLFIZoF68y8jUIzPTFY99I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQXhuxTvU8+dWAAp27dFwCyw5UpBvaxVnQd4njXVE4yZnqIcor
	W2eqnHxr7GWHS51kqdikPx9GGwvHcwVHGwSiy7BQktImwSpD8f3hdRX3Xe1YzsfXXOTJIsw2dui
	KZTV6yd/bKvCTWB1HN7JZhtl1gcrHohEt25FZiISQL76AUwO5z+JJlTzpo7aYR2I=
X-Gm-Gg: Acq92OF39BWKc2xTgMHGBXjjLX9m+QsnO6hKYYLyFYcZuGpav2xwp9nyiyIR7THSfKG
	6BQThHHQdbLI22WAksor9QVg7cnd6FthcsSRIm2+Phsz5oUGlrdwP01vfbiTNfevXD7cElpyxjc
	IYNUH08OcfbESYvwrmPipDyh71P1KbgUN9zpVS+oFBX0PVOaLEeLT3sm7gTe0l4FhWwc9SsM8Ja
	PSubenYIQq8l8/9MqDsvQE1nN2Eb1GqNI43ES71KYCR3Cp/JNcDGqvzJ16vMlZJAjwcL3DA/Xh9
	96vtKlB5R1NR/2VsuaA8CpOtEWZNgMwWw6npOdsUKcIJ7p+wUJOqXmRXj/CBayqKgFUHLnIeqpR
	U0F4vto3LZavv9GU7g1Z6oI9XL25R445sQfZ4ynmR19YR9XBk76MZa4ho7euxisVgawkUwJRhYj
	nhCTAFF5OAUstOUjrS8CDJvmdVzjXDM2oKcHf2cXQ7veG75A==
X-Received: by 2002:a05:622a:180e:b0:516:d70b:25ce with SMTP id d75a77b69052e-5172dda8cf7mr30123771cf.55.1780053459035;
        Fri, 29 May 2026 04:17:39 -0700 (PDT)
X-Received: by 2002:a05:622a:180e:b0:516:d70b:25ce with SMTP id d75a77b69052e-5172dda8cf7mr30123261cf.55.1780053458455;
        Fri, 29 May 2026 04:17:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa5b793b9bsm211741e87.71.2026.05.29.04.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 04:17:37 -0700 (PDT)
Date: Fri, 29 May 2026 14:17:35 +0300
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
Message-ID: <urft4kklev3palxzpkrbif3jx3fuwdzlj7weyjtodl62vbbzto@v3tpmfvsrlku>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-9-f51a9838dbaa@oss.qualcomm.com>
 <4guumv7ve7rshw2pjvumenopxsefha7hvj26tw2pgayz24ytxk@iry6qyqqqs74>
 <cd43a941-5672-46ed-a9e6-1bc134c94e03@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd43a941-5672-46ed-a9e6-1bc134c94e03@oss.qualcomm.com>
X-Proofpoint-GUID: PG5ar5NRZzg5si6Ka7VODfrIYstW3xRH
X-Proofpoint-ORIG-GUID: PG5ar5NRZzg5si6Ka7VODfrIYstW3xRH
X-Authority-Analysis: v=2.4 cv=auOCzyZV c=1 sm=1 tr=0 ts=6a1975d4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=I4w7QG70X0q2cnev5jYA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDExMiBTYWx0ZWRfX/Q14MkyptT+u
 0ewX9EOPG6HtTnQirzjwoPafMWKGnKnhLcaX/HAJyzz+GkIEzr+K/tfpWZ0l8fQSw7ZyHjOtckH
 9BneJgnhw9U71hBkwGYi62E5sq8/0K4SzEznODWe6KVr+sUl3VmkBoEbjt0YCPFvYzxqwzz/6f7
 Dyf6FW1w/eHb2wK/0sZlCYKhZ/xpbqiDq7EnwgDL11T4lR6oro7ui7cZ0Nb7JkFIB8w7kSuoXvW
 fA2gEUiHKTfJ0ijVr+atqHqbxEi2GOI3P/YF7R8OEwWntuk5+mr3mgyUIOx8ZZqFGg0xI5uP5rU
 mtJ6xt2npGEkHam/5cEAmSwrZyXfOfixBK++zmkQj3q007pDuN0prB8QD577phRI/VpMqExYXGA
 i29ufn9CWFsBN7iTSnWYLJwvc+RiTTIc7k8UQUA3u4kvJRopRs7EkNAFCyqRDjUf9y3k7IsQWXU
 6bTtIt430kDX9T41EEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290112
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11028-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7B27B6017D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 03:41:50PM +0530, Komal Bajaj wrote:
> On 5/25/2026 2:57 PM, Dmitry Baryshkov wrote:
> > On Mon, May 25, 2026 at 01:19:13AM +0530, Komal Bajaj wrote:
> > > From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> > > 
> > > Add nodes for remoteproc PAS loader for CDSP, LPAICP, MPSS subsystem.
> > > 
> > > Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> > > Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/shikra.dtsi | 164 +++++++++++++++++++++++++++++++++++
> > >   1 file changed, 164 insertions(+)
> > > 
> > > +
> > > +		remoteproc_lpaicp: remoteproc@b800000 {
> > > +			compatible = "qcom,shikra-lpaicp-pas";
> > > +			reg = <0x0 0x0b800000 0x0 0x200000>;
> > > +
> > > +			interrupts-extended = <&intc GIC_SPI 257 IRQ_TYPE_EDGE_RISING 0>,
> > > +					      <&lmcu_smp2p_in 0 IRQ_TYPE_NONE>,
> > > +					      <&lmcu_smp2p_in 1 IRQ_TYPE_NONE>,
> > > +					      <&lmcu_smp2p_in 2 IRQ_TYPE_NONE>,
> > > +					      <&lmcu_smp2p_in 3 IRQ_TYPE_NONE>;
> > > +
> > > +			interrupt-names = "wdog",
> > > +					  "fatal",
> > > +					  "ready",
> > > +					  "handover",
> > > +					  "stop-ack";
> > > +
> > > +			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
> > > +			clock-names = "xo";
> > > +
> > > +			memory-region = <&lmcu_mem &lmcu_dtb_mem>;
> > > +
> > > +			qcom,smem-states = <&lmcu_smp2p_out 0>;
> > > +			qcom,smem-state-names = "stop";
> > > +
> > > +			status = "disabled";
> > > +
> > > +			glink-edge {
> > > +				interrupts = <GIC_SPI 286 IRQ_TYPE_EDGE_RISING 0>;
> > > +				mboxes = <&apcs_glb 9>;
> > > +				qcom,remote-pid = <26>;
> > > +				label = "lpaicp";
> > No FastRPC for LPAICP?
> 
> No, FastRPC is not applicable for LPAICP. FastRPC is primarily used for
> offloading audio, sensor, or other DSP-related workloads, and is not
> required here.

Which likely means, no compressed audio support?

-- 
With best wishes
Dmitry

