Return-Path: <dmaengine+bounces-7656-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC77CC2C3D
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 13:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5DF3230131D4
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 12:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F049357A2F;
	Tue, 16 Dec 2025 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WTuuKQx8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="brUftz0u"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D713735773B
	for <dmaengine@vger.kernel.org>; Tue, 16 Dec 2025 12:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886587; cv=none; b=u+zRFkAwdNtP3wM+qvZkFpE4QFOTR01vx04HiURPgTeFmUcQlFTgK0v9PO/UaxIt7wBb0xL/db0JTpXqEoJBk/7IjhbgrToeP/zY270fSVQy+xew7rtj/+PKjSpbfdFzRbyA81RfLDIYx2z4d3YJsXGGHKtcJ2am/DwBeMkvKhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886587; c=relaxed/simple;
	bh=1fqkqkNEzTSWAwW3B+qpzd2aY6yMg5j1xLcgYYtCn9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCSIU5QtS7XffF+w1hrzBdntci5r3/1DgKtJVnfpZuwRHKzSwBY2D7eV+Yh7ZD5FgpvY+Fyc1tG7ht6upf1t0MzNYsX9U9knmCVJvK9N5aa7uQB1Z8IKVl5uXnme1766gcLJHU1ZFzb0ENE1xhuh/LdXwDBSgujRoWfqwryi++c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WTuuKQx8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=brUftz0u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGC2GdO2810368
	for <dmaengine@vger.kernel.org>; Tue, 16 Dec 2025 12:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S1bUZC3wQ09/vUi2Wz/LwL1M7PS4s9jI4u+ipA1NkPU=; b=WTuuKQx8zjT7yA9n
	RcbkvqABZwczl032YJYNNIyEMQQ0tM+vIYIzu5g3Dn6Vu8y9nSVDA/pHjGy0I+DO
	kf15TiqGU4+zNGPYK06xCKaXZJ7qclWs1jao4YkvXbKIZ+pyozusvyzYCINi6/br
	lzPLi01djXZzGrCWTp/xAGD0biZWoAwBN3OsG6oF/2MURjRalhKBPSMz+q37jOOJ
	ZGEoNU9XbiyPLo0IR26nMlkTduTn/0lQvy11X/NvYy+zjberHj69u4tyOk1aPwTS
	9jI8WWAUDGCRH2jNuU0sknu4VMLaz4s2VrnNfRIrO6wuKogI4/A5TufHPHXhPrLf
	BdTovQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b32gas7ek-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 16 Dec 2025 12:03:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8bbb6031cfdso67002285a.1
        for <dmaengine@vger.kernel.org>; Tue, 16 Dec 2025 04:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765886580; x=1766491380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S1bUZC3wQ09/vUi2Wz/LwL1M7PS4s9jI4u+ipA1NkPU=;
        b=brUftz0u9slhPLGiWz/UOVN+I2nfhpd3OK9UEFORSoD5YK6CInrMQz0rD0sItRzt+U
         itk4Sk1NmOqqRh2nPrMUbyQVs4a4nTzM0XUxxw7tgjDGA072nhi/rBJpXvXsNPmO4qbj
         bYN5rgewjYB8esFh+CWnKkK1POpp19QSpbohWOTdb0H7PsMx5zY64XzkQ/rt2lNbTxIW
         NPT1ldNGLqmf5E0dfpMGWYKcLa952UNe7IOlrKLulfi9W5UVsItBB8AYe2FJ77HjL/0k
         34/GbNTaLt/pEcjW00kii+95cFMOUVgsnjUx3sBPJ185n+tBUMrkhixlr3k3EasjSW1g
         dhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765886580; x=1766491380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1bUZC3wQ09/vUi2Wz/LwL1M7PS4s9jI4u+ipA1NkPU=;
        b=bsGWrl+8btQR28Cax3dY7nDMAdgS1CZ/GbhYyhscB7pIzdcLavwKeeQZyjIQgcQ3wk
         wbTQngDOELCE0uL22OC18z2gj8khWQ+sPPsg6/PJXSkw72OwMnp0/GjIqk4eevLVSiQk
         OhzbYta3++n8945xiR9A4NAq7bR8GPJk0gHUQ5ufQo9GcIsgqbYxG7+GY/fb7KcFh8w1
         WP/X8+beUOCC7XI3hNwNt1IXJ6LcQj4xzLc7276GRM4UaNp0BBItBlEUg9DogHGPp3uO
         pqckiNKmTUvkNobucaETwMnfJ9Y4fiiRpTQfjyJNNTjGYFCFjPnA1aM1uAKLXfunbojf
         3bCA==
X-Forwarded-Encrypted: i=1; AJvYcCUK6Ogq7bETrIkxscTh9jz+zqe47lxu1yW3Qzmns49HsIdF15Yc4OEJqjeN7tzVlcWTSOhR53P5NVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx96Q4hxGceeE4QRF2WobSY7S1FKUxkWk1sKE3BI7sIE8E6N72a
	kskvQKNLZs6Lm84Fy5qU1E10+t5/nhGGfaz3AvUDR24haG7JOjTx1EJqxNPb9cMWEghA5MhUMI/
	3IB7J7eamE1cdesFA7Wy0s8/pcY9gXScRhL40UuBEhglrJqSv3PyNth+9P5z+egY=
X-Gm-Gg: AY/fxX4x3Rqbl6a/iTnf+q1MItpdjFdxKcAmCcInSunykHVNzf2xLzpcpFJck6hXpes
	x0K9rMcARen97fo4Hiw1dR5ATq59sNa3sS+1Sof208raPTmJVmWWzDtgpJ5fhlWmjn4JZHCO7yh
	5l8aCp67EmZCOItDk5X4iwOiGs+Z2oE2nNhbrHufaX272fbdSvdtFbVlgkj7wqEQYaF0OKDm3vu
	7wMdnv0FdUY4BzIKzUDJukxeI+owYv1YSHskCEeaYmW0CeFXLir7lbjGQmjTxWCCPoAIhs5+VCD
	owYgiyr+XjrCtWLTjIjFgQ8BtiUdKXpZsF19fdfBLhMyoS1E8bYvvBLrso+2MpY9Wea9ptpGGBE
	62FKB2WF1Xxu3xxrcDfR3yMoBKOd9MkeGlDXI+dk9/RyxrHe3hx2wkhQzDEr8l6OTyA==
X-Received: by 2002:a05:620a:468f:b0:8b1:fa2a:702f with SMTP id af79cd13be357-8bb3a0b7e5amr1437508485a.3.1765886579713;
        Tue, 16 Dec 2025 04:02:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+LwGQhgX+HV6xSu98Kp8PBKIcLhjvja7byx1nEf8nekydl7DDS37zTtoZtPzNHvCnZUEeTw==
X-Received: by 2002:a05:620a:468f:b0:8b1:fa2a:702f with SMTP id af79cd13be357-8bb3a0b7e5amr1437499185a.3.1765886578963;
        Tue, 16 Dec 2025 04:02:58 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-649820f77e3sm16041066a12.18.2025.12.16.04.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 04:02:57 -0800 (PST)
Message-ID: <695ca5d2-b713-4838-8427-a9d31751c0cf@oss.qualcomm.com>
Date: Tue, 16 Dec 2025 13:02:52 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: Remove unused includes
To: Jonathan Cameron <jic23@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michal Simek <michal.simek@amd.com>, Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
        Peter Rosin <peda@axentia.se>, Linus Walleij <linusw@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Philipp Zabel
 <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        iommu@lists.linux.dev, linux-gpio@vger.kernel.org,
        linux-sunxi@lists.linux.dev, imx@lists.linux.dev,
        linux-sound@vger.kernel.org
References: <20251212231203.727227-1-robh@kernel.org>
 <20251213165949.4b51f7cb@jic23-huawei>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251213165949.4b51f7cb@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Vcb6/Vp9 c=1 sm=1 tr=0 ts=69414a76 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=i0EeH86SAAAA:8
 a=UbNXja__m5_aMge2JzcA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: CqTAPmh-rQOIbiYzyfuJlu4A5npgckNB
X-Proofpoint-ORIG-GUID: CqTAPmh-rQOIbiYzyfuJlu4A5npgckNB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDEwMiBTYWx0ZWRfXxNoRLjlqhJy9
 NBhy9zrA3I0jS4ATfV1FjIaTH3yogxzbcFNfy+DvHez5xhJ+gV/OSJquLE9W2DdXPVBjS47CFqV
 z5w/TBTVWMGaWB+GQk10cpTjTppdIK62iVsywR46Mc8Pd3eLDI2sKOX1rS7wtGqoZVg/pny1KTp
 PUbC+DX0mrBEOZ6j/qGckcM0AMqws7sEkA5532ZdATnpYfz+fCyq1HOY3cPsbf8z0ttcLMvIAxR
 ihity9EnBH1oPGQ//1OoHbUEGnScpo8E+RichB3GEZ1DEGpFFacunFK///6F8y8vHJSU3auSiUl
 qEuoTJipvZDN4Irmf4WD7uZfVJqBde7GDjpd5R7CmsPYKLfx5zoch8fJoMT+tekrQmutmR7D10n
 QaVozp8gm9Q+AYi+hjFhElJPC7D7+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160102

On 12/13/25 5:59 PM, Jonathan Cameron wrote:
> On Fri, 12 Dec 2025 17:11:52 -0600
> "Rob Herring (Arm)" <robh@kernel.org> wrote:
> 
>> Remove includes which are not referenced by either DTS files or drivers.
>>
>> There's a few more which are new, so they are excluded for now.
>>
>> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> 
> Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com> #for-iio
> 
> Ideally we'll get a QC ack on those as well.
> 
> Jonathan
>>  .../dt-bindings/iio/qcom,spmi-adc7-pmr735b.h  |  30 --
>>  .../dt-bindings/iio/qcom,spmi-adc7-smb139x.h  |  19 --

Those are being moved to dts/qcom:

https://lore.kernel.org/linux-arm-msm/20251127133903.208760-1-jishnu.prakash@oss.qualcomm.com/

and will hopefully be in use later in this cycle.

Krzysztof and the submitter agreed on that outcome since they represent
hw constants and aren't "real" bindings (connecting sw to sw)

Konrad 

