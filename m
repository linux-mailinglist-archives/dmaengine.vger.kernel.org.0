Return-Path: <dmaengine+bounces-7058-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 825D4C34F97
	for <lists+dmaengine@lfdr.de>; Wed, 05 Nov 2025 10:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CC514F9FA2
	for <lists+dmaengine@lfdr.de>; Wed,  5 Nov 2025 09:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E863074A7;
	Wed,  5 Nov 2025 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HWZ7Yygb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UzoBfa6P"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02842FC874
	for <dmaengine@vger.kernel.org>; Wed,  5 Nov 2025 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336260; cv=none; b=nKM5LUdZKadj2ms3SxKNrFON88ldTAdULQIAtp6aZKcTLO1XGpr6FAAwWebkPeYvx47S7yWuAT63CKXnohctewA2aiE5lGZ0GTB6QFaiMZ2yWEMGdoAhsWIkBKdP9OyVWKYjhWXPoY2Nbv8AAaGobQlZsWknW+z8hvJbOj6hGuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336260; c=relaxed/simple;
	bh=Wz9pz6+tUXLoQmGQHZtV2nfAHoQ3q7VvMhyrm4ZiN9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ulDpGG5urYgSIsyLt7DXOA3ivbwPOVVxRPkbcJW9WMSUH9TRakw22oOVSysqiBw+LbVyXz/X6cOVHLx7SjiEXStRX6pKN8ZOt0UtQMcmb0/RS8TIi5zyANbkil2dmYuKBsXYi7NUkktTCoTB6eQ/YNZ3cPBh/Mi+B7V24Ku2Wnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HWZ7Yygb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UzoBfa6P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A599ilC356678
	for <dmaengine@vger.kernel.org>; Wed, 5 Nov 2025 09:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ne1vLI6iVgsCQJEMuLTX74xqCKIhtplm71Ycr58Qp4Q=; b=HWZ7YygbsUnH8nYI
	+DqZotw9gcbMFfmNKo88cPp/sOj0ogWBMXTtbQ/2IITJ65Q/12l2Q4hz2kiDEIou
	dNnCcisD4J6Xd33zxEA0XdxOZDe3Fy+55Lu4eEQRm0gk5pej/cF5mygK7q3jPfjo
	keV/M49YHsX93a5jXQt0NhEWQe2ZKNvC/qufXxbMM4t+Bk/ELJtNVu0B+8LqXHnn
	p75rJLYMklfQy20iQEQTFq49XxYIUlKa1LIzHvCIPEnDUZQKGF+290u3jYhPx4Os
	1c+YZAvPhtlcfc3k73Pk6yH3YCEjHf9sf6EKB4vhRMstDUu5Y0CrBgTFkpzovjvz
	EVWqfQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a83q5g3tu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 05 Nov 2025 09:50:57 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-26970768df5so17621275ad.1
        for <dmaengine@vger.kernel.org>; Wed, 05 Nov 2025 01:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762336257; x=1762941057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ne1vLI6iVgsCQJEMuLTX74xqCKIhtplm71Ycr58Qp4Q=;
        b=UzoBfa6POtCJ2n76AOUCUzCegIRAJEJ7qLuCkuWHNg+g0z0ARp2e4FE8CvkfJ3T3rA
         oPqzBC0wG6pC7fXoqM/LGpRYoDI38yHdIOF+6M9YFC6anREzL5Ina8mfSBkZsteON1bc
         1sqK//tcaKVYhyDqzXvBu3f31oHqpwnMWVeL1FhYaeG8nfYlMcSK9b1VJEpZOWIeO9rR
         HkNyGf5+VOayAtaEvHKGexyatDQ87xgYMZR9PY98oyjDzGeykGm5TtxKAxDR4tWKAFf+
         MrV24+ZYEfwHFRWwU8Ruld6PSOVO+taYZX1I2/h2CQ1rdH+nQIf1tBf8mpUkATYZgplD
         14lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762336257; x=1762941057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ne1vLI6iVgsCQJEMuLTX74xqCKIhtplm71Ycr58Qp4Q=;
        b=QQ9oMbKvx9Bkorwo5HAoh5Wf46FRGogOxA5J+7w3PJWTJIvB6D03z6oHIaXQMzblpI
         xAtpIjkn0rsQT88jZU9lYSshGOeXa832fgB3aAIUIccUj2So9Y44E8n9IAPjPvqLha0P
         AaFN23u0M3uyvhQ4wo4OSKT5sWprae4m3c233ELirRrI+arEolqOvexVQkd4dHvzcIjQ
         szFDixn9e2PMd0pp3O9utmR/D0RN9j/w9Z9VwkOvBV5fML2oH8DNXZ+Wz5WhrHSu3yKs
         uv4eBUsaFkU39M9xE8wDCAB6wdhJXTbYjU82RKF/dAPlIK/gtynVTloWkM4zVRVRST4e
         OQTA==
X-Forwarded-Encrypted: i=1; AJvYcCW20yhH2ZcCNNa+3flHUS67X6hQYbXhyVfz8iEhgIFm9leuhhYQwS9n3NMSfnP6SeZ7cRf77peC9cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCJYcUy6/vzlDYjCYEGXKRvrYqsIDjiboNyqLhbOaCVvaJ6oug
	LTLFN/hMiVIMj2rIenNPg4IW/BJw49StP2NkcESQHzDVnWcLUnaeI6VkSBF9wGD243x79iY1WCH
	XJIMjP/pNCB/Rv1JN1OtewoRL+0m+Wou6cQ+aOZMjXOHiAfpdXlHHRAg9oSdTpGk=
X-Gm-Gg: ASbGncsx/MmnbYw1kr+tUJu8VqVYGz+wq9DNLUpIDo7XuuetrWBINnCakzTkMXHRXGK
	KFGCnt6csY3WNqI1297uSQqvwPe4c4AZPYI809TzZipe9LsV/wy25pj4kb43MmkAFGkULxfYwS7
	CmY3OGmBlVlpegFQwHNrtAHRL0B5Z8xnu0fRSWGujdpFKjCv0d2eeR1lQ0KVRlJsG3XIMtAOpbP
	aU3iikPu11Z0yt097FR7g7k6hKZ44C9vnzksGALiD/dBeRTpYCHOlfKW4q8ONDGBk88f2cU/wu2
	zY14Y/Qt98JTbQ6zNdHztULgoUQ6wi7pIDFvf6p3HMyeyEoq//enHtz1/hC+PyQsXi5ZZejTKId
	c25Yws870nbAH8jHn1Jm6FkRznXG1ACTwzik+HIsjJdB1+9TEoBGGJjLYXoDLjcuT/g==
X-Received: by 2002:a17:902:d481:b0:26b:1871:1f70 with SMTP id d9443c01a7336-2962adfc959mr20850045ad.5.1762336257171;
        Wed, 05 Nov 2025 01:50:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqwv1Ydy5K3oHLxa6rtDjqvwFgbdcNFOCKsKVhYaJblg2CGwvVVnkiFHWhkWFXCyv8JvmyUQ==
X-Received: by 2002:a17:902:d481:b0:26b:1871:1f70 with SMTP id d9443c01a7336-2962adfc959mr20849955ad.5.1762336256582;
        Wed, 05 Nov 2025 01:50:56 -0800 (PST)
Received: from [10.133.33.129] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a74214sm54253835ad.97.2025.11.05.01.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 01:50:55 -0800 (PST)
Message-ID: <d8b302ca-c2fc-4583-be77-6b720d5bdab7@oss.qualcomm.com>
Date: Wed, 5 Nov 2025 17:50:51 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: dma: qcom,gpi: Document the Kaanapali GPI
 DMA engine
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>, Vinod Koul
 <vkoul@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
References: <20250924-knp-bus-v1-1-f2f2c6e6a797@oss.qualcomm.com>
Content-Language: en-US
From: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
In-Reply-To: <20250924-knp-bus-v1-1-f2f2c6e6a797@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: HbHj5hMAjLvy-HxVt2wuyCX015O7x6LB
X-Proofpoint-GUID: HbHj5hMAjLvy-HxVt2wuyCX015O7x6LB
X-Authority-Analysis: v=2.4 cv=YZKwJgRf c=1 sm=1 tr=0 ts=690b1e01 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=2uM0ewAiIFN9BRPiibcA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA3MiBTYWx0ZWRfX5jY7K5wDB0oW
 Tl45i3itCQvRH3IjvcXICqZjbj9IFrLwwgj+mVmjxABS7GeL3oapaI45xhp3YfeOC/9PsYlMimU
 si0GWfbIJKqE1erFyqfgdEnAa9gzekh3V0yduewCq01ibR+oiMhVImP0LiZNJzQv4/pe3y9fiAF
 MBHhZQrxo8bMrGr6ETRdFJTSRszOsiKVJfpjLZjbZo2G1FqBMZ2HOU99y3jD9q5O5k9JDMlAMXV
 Nv0593ABRbnb+5nEZXLdyPMLVhvoQaEKFRPl+autnRnPQaSKnKrSlEt6h8eKqCfA7tsV2i5EjQp
 /681788+BBEI7ZAzL3ZGUDJsBGVpS9FOLO2N3Iky3qEoE11IKWWV8MbzHlhZbiFMRcN39hsjS9i
 uQRY72DW6Amh/rMkRFUW/BL6K8CBpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050072

On 9/25/2025 7:44 AM, Jingyi Wang wrote:
> From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> 
> Document the GPI DMA engine on the Kaanapali platform.
> 
> Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> index bbe4da2a1105..e7b8f59a5264 100644
> --- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> +++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> @@ -24,6 +24,7 @@ properties:
>            - qcom,sm6350-gpi-dma
>        - items:
>            - enum:
> +              - qcom,kaanapali-gpi-dma
>                - qcom,milos-gpi-dma
>                - qcom,qcm2290-gpi-dma
>                - qcom,qcs8300-gpi-dma
> 
> ---
> base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
> change-id: 20250917-knp-bus-e5ede66d8e0e
> 
> Best regards,

Suggest to have glymur support[1] as well like other similar bindings
change:
[1]https://lore.kernel.org/all/20250920133305.412974-1-pankaj.patil@oss.qualcomm.com/

-- 
Thx and BRs,
Aiqun(Maria) Yu

