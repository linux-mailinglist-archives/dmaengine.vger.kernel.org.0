Return-Path: <dmaengine+bounces-10484-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJjXMmcXB2qQrgIAu9opvQ
	(envelope-from <dmaengine+bounces-10484-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2026 14:53:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6376854FF62
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2026 14:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D4643153DD8
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2026 12:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E0B47ECFE;
	Fri, 15 May 2026 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CYTSawVv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XFTww+Zh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4127547DF96
	for <dmaengine@vger.kernel.org>; Fri, 15 May 2026 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848030; cv=none; b=UUqJknfQSeUUNW3rDV4WGMWUXntcpf/UuByasR0wgXuT3bsCyJoRK8qoMPXBvCaFkwhLYX7FXCCl7acuq2H3rogPGEplMTDpdXFPrHy0CgNDT5qqzwQ0ivFG4khMuwwLRg8rTaVvqr2XWnNlocGSuSpQSvrSzjWFsxAMXiJMybg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848030; c=relaxed/simple;
	bh=OqwsAITcYpQz/wSqoeywZPQG18Vmp5n67YNxhye2MQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PuI2/MYynsYNVdxiCeNKwxfQqFzYoURz1xRLpIk/Ta4SOSSAn/UoAdQDfSUEYzzAXIrwbPWlXclzhwsorv6efpKeQNK18xZfO4XxsPsPIP5f9BWajC86fi/oHpFQrSfU3/4/WoHzaEmMPzEtOqzNTbLA0vWHcV1oOqubLb5pkh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CYTSawVv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XFTww+Zh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FB5b1I3200085
	for <dmaengine@vger.kernel.org>; Fri, 15 May 2026 12:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PwUtDhTfzwCwRc1ghZb7/Ai7zYeJOhR4rLibL31qz70=; b=CYTSawVvqP2Vf0Z4
	y+thgS6QrXkcUlFvb5JLKccreitO4FzzZg8p3VGinCPwJSoCyBpxazAWzf9Ee7Pz
	eetSA6FTD3MEgCU5VACLWutVGfPWgxvFXr1690hTyxSs0Q0uxAaoAgC8hwKli3ui
	OkJluF7LBjeCxly2TltkMZMGZ3MdUhItBkNM8i/FIrCSERaxECx6fDDVjxiTiQLl
	Zw5SSMgZsZaYFk0LiQIbsB6za8GiCgTkzqJAhR//Stuhk8wKUgPmg+HvRIzneYs0
	wimzpRRtW/jPO8wzVbJI3hq2v0LOk4EGmCTZPGVCBt90p8Ik0XquDnJhx94m6XOs
	tyQ0Jw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1qu66p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 15 May 2026 12:27:08 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c829586e894so3260389a12.2
        for <dmaengine@vger.kernel.org>; Fri, 15 May 2026 05:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778848028; x=1779452828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PwUtDhTfzwCwRc1ghZb7/Ai7zYeJOhR4rLibL31qz70=;
        b=XFTww+Zh9ySCDlsoZaTG9YlzljK1kL5p8WX+Fv0DjiLzPss55FmxVWP+WyAk/meM9G
         NHlLVqIbEAYt3C3L51V5Hd3NKFivWgVIFkzRXiSpsgW80GQYWCYZyR6cRm0nnXMijZmT
         9JGmZidA4Iwp5LhsxgMMf3XruOCRbu+jHHxjdC1yYyVWWEPpDiBSheRJD40w6tZuKujh
         PgT2lPD3txSB5uJvJQ4nP7QLno624IBq1KxwohFE8BreAmTB1EAJiFzLPU3Zp2tb1C82
         kDa0v3sFCaS8TXFzrr+gBqzqNh0Bb9O9C/Thmj7uSXWrTMGWEzbolPyObOyhRRc/ZUE6
         xb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778848028; x=1779452828;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PwUtDhTfzwCwRc1ghZb7/Ai7zYeJOhR4rLibL31qz70=;
        b=IyX/dEwsEm0eedTzsIFEufARNhZOkDPCXx/j3TgSyfRvz4fqgXJbzSLvIiEKbqVmkv
         bsHCrqiUWaJ50Eo3f/y27ya4HcLvpO8fmSAtCLhnLGZ2Efafvj4dtelNO+XvPslGbfml
         yNmRDNYhWM2/Nz/yMjUM/uQIAU5dTarR0cd/U9Y9FWt9tQx8ZSgBdFvIV+g9pXn8yJym
         lKsQY0tBQ9VRWB84cUDlVJiT7/dV+m8Vb8Lo9nW6xZA6tP7GOH/5D/13QL+RZ2ttU9oH
         v9njTWschaVVaUK7f1mxri6X0Zc3SPgSkqOQaNK0eeDbGd5I/UQ1klkuj/XzBaM573/b
         EbIQ==
X-Forwarded-Encrypted: i=1; AFNElJ+XJXpXjXst/yX1O6F9X6OjVliOHEmUhBth/2QF1NdH5aS5zxDKrP7wbVH5uAX+31T4Ck5rbDqNMK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA7nbe2ZlHe5eRZrnkvIX6UwztlQVuNy+4xGotYMKFAZgDp71r
	Yw/obkVDmYGkee3Pmsw51pvI57ieMywJpacty4Bj8C+hLTGVAdp70J7BJSgzwLfOd1P449nvWG0
	RXrQdyPBBLlR8kSU4cI+F3DBjOkY2cGeD79TRkiEk2poOxlWAVwFO6RLfnHlkZRE=
X-Gm-Gg: Acq92OE4Ihpr/BQfTlwfhQkkR6jOkNtgX/36DLMse+kP53BHEbnuwlFBQRVSAzrDCad
	4BDQieXji2QHEUmrXpTvgEhj0/ANvMTnw4lv1UR9G7FUtJCjpYibXpeI8o1rA0m09Xx8L0Elqg6
	9TH2PbYdFYwYAeMBlZTa1Wakc7AXsd9khA4S0pLth2B6VtTrcrrDMAHvIduHzCsEZoVvAVIO3GZ
	lqA3XNhqFzeKD+r0oRXE5K9HnDWAnt4gCqxZdIDqQSvKy081jfiTDV+fpgbHTLN1aX2qqAHzuY2
	7qMROyOrAGRpQQHFUZDvJ+ataPDgZwR5MzV9f7e5y+XDd0kL9oZQZm3x7GQjCAJ5bhEJHtSVXM4
	C1/tn5Zhg8PZ7S332GKCjqZnz3tD/TTNurzEHTjI8oFj0CmnoH+9TBCxQSADavthpxVLiX1Vigf
	RccQEB4Q7oBZkPE0mnlsPw5esov8W5mNkzYhSNzmhT
X-Received: by 2002:a05:6a20:7491:b0:39b:f026:6f8d with SMTP id adf61e73a8af0-3b22edb93damr4340166637.43.1778848027738;
        Fri, 15 May 2026 05:27:07 -0700 (PDT)
X-Received: by 2002:a05:6a20:7491:b0:39b:f026:6f8d with SMTP id adf61e73a8af0-3b22edb93damr4340127637.43.1778848027241;
        Fri, 15 May 2026 05:27:07 -0700 (PDT)
Received: from [10.190.200.212] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb121ccasm5188482a12.29.2026.05.15.05.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 05:27:06 -0700 (PDT)
Message-ID: <d5ecede4-a5fb-4721-ab5e-53950ee5f822@oss.qualcomm.com>
Date: Fri, 15 May 2026 17:57:02 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: dma: qcom,gpi: Document the Eliza GPI DMA
 engine
To: Abel Vesa <abel.vesa@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260515-eliza-gpi-dma-v2-1-1255b43d5ca9@oss.qualcomm.com>
Content-Language: en-US
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
In-Reply-To: <20260515-eliza-gpi-dma-v2-1-1255b43d5ca9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HbkkiCE8 c=1 sm=1 tr=0 ts=6a07111c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=JINMlsxC23q2cYMMw6sA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: nGbw1sqioNgLg4qjgJMTXHrTcdPxaqoQ
X-Proofpoint-ORIG-GUID: nGbw1sqioNgLg4qjgJMTXHrTcdPxaqoQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEyNiBTYWx0ZWRfX6epKyMUsy9m3
 6qjDOuncsmWN2CAvabdsSlg+TaGVlXj7mD/Av0SSl1dgdMo/KiDOzvJBgzJVj8gsCoBGBfBCNuZ
 avnoruvBXdG2BaUd/OwgUKkANdPz0MYy1a0yrbFTs/Oagx8p9gWcyJOfADCHr5HkFS+8ZZKgUNi
 O3NgjsElp9eaF+8yFaW8PguBQ0GG92HJH5U8oDN2NyeNKVauK1LUtESjgV850NEEcIx4e0P1GTI
 GVu7wvXRRwXDsCgxbOz0P0PyLr0/JS1ciBe5JsyzuOHpJOl2FZ1nP6WV9y0NOtuEEaTHOu/ykTh
 IWwL6RrMZ+r0FBBcH6vE0woG0M85MXGd7YiP8bnEkY1CSt9/sZkpT1ACAt94cbBR8zDMHOagMIT
 rTmWq75cQW3qdKk8s2TS0b2uByY+JDQLb03R7AzTbTdpSesOD/zrHLzSkDA5hrdDjLE9sQY/A66
 Qzl1zUwCXsy+3FuLkag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150126
X-Rspamd-Queue-Id: 6376854FF62
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-10484-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pankaj.patil@oss.qualcomm.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 5/15/2026 5:09 PM, Abel Vesa wrote:
> Document the GPI DMA engine found on the Eliza SoC.
> 
> It is fully compatible with the GPI DMA engine found on SM6350,
> thus using qcom,sm6350-gpi-dma as fallback compatible.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
> Changes in v2:
> - Re-worded the commit message to mention the compatibility with SM6350.
> - Picked up Krzysztof's A-b tag.
> - Link to v1: https://patch.msgid.link/20260513-eliza-gpi-dma-v1-1-d8e37f026c36@oss.qualcomm.com
> ---
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> index fde1df035ad1..d40b0a8dc9e8 100644
> --- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> +++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> @@ -24,6 +24,7 @@ properties:
>            - qcom,sm6350-gpi-dma
>        - items:
>            - enum:
> +              - qcom,eliza-gpi-dma
>                - qcom,glymur-gpi-dma
>                - qcom,kaanapali-gpi-dma
>                - qcom,milos-gpi-dma
> 
> ---
> base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
> change-id: 20260513-eliza-gpi-dma-6b5341271f09
> 
> Best regards,
> --  
> Abel Vesa <abel.vesa@oss.qualcomm.com>
> 
> 

Reviewed-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>


