Return-Path: <dmaengine+bounces-7859-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F3ECD4B5C
	for <lists+dmaengine@lfdr.de>; Mon, 22 Dec 2025 06:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C8A33010CFF
	for <lists+dmaengine@lfdr.de>; Mon, 22 Dec 2025 05:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7ED3009C1;
	Mon, 22 Dec 2025 05:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JaqE8PFX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dvhd1clY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E3B2FF657
	for <dmaengine@vger.kernel.org>; Mon, 22 Dec 2025 05:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766380226; cv=none; b=FOegZjQyC5NqNj5L8AbamGkJIvZyaxlbmR2Qad1KRzhNvH4Yz87sOeXudk0WQ3V1ucK2j/KpOKl+dy4Y3xtARyIy6zS7n9WA9Jy/PQcOs1kghG4pFC9mTMBOHsGFgRpT+BUTPOaF3NSKCHlJ1Q2DTlTpVMHGdT74kTqVOwTLFJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766380226; c=relaxed/simple;
	bh=lEz1EO9+5vHP/vkBtalnXRHK5Kz28Zn3kdtPr8JcOLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzXKwURq5HzT2HX6I91kL1Eg6I8P32m77MSDBEfib7BXExtRYolbJALp+ner8qRy0f1ZUPDIYlZjx3w1kZeXTmfNmB490/W1hPzdmi6VPRnJ0Fl2voiYCwS9VrMDHt9EwqiSvyzkz263DKfpBu8gMnux1F7dgZC1/pU7da2pD9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JaqE8PFX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dvhd1clY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BLMpvSa3572792
	for <dmaengine@vger.kernel.org>; Mon, 22 Dec 2025 05:10:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HXbQkXLbPCcnMf8qSQ3UYnKPQBMFv/tHJAxobOvHBqU=; b=JaqE8PFXQGSwLVGB
	Y1+/XHQ0OATA7vElUPkQoDgaUiFG1HJ5h7BlgYAJ502tsiSZnEBYNDzWBuJA26Qx
	JnJ6dp18sjrQN+yQYGBqJPOT7pPDvwrr4sSFjk+zqDwwaMVYiU8UyOCRjmrZTq6P
	toXDd1mZHvV5u79MqQ5kzh+A0Ku7lJUsgkio1mjpjorCp2d/zKorTWkQ+lZ5EEY/
	VsXgNi7Z+o17XUODF2RY9i+DI0Y3CQm5/AKti/UWHCvZqD1TpDyStqwYfNmP4FG7
	ijrN0Wq52YuIpR436dAfRubAPjt+beIKjSJDNOqpmm0qxoydDfNLtprDZ74Bika6
	PkHkaA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b69ahj04m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 22 Dec 2025 05:10:22 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7b8a12f0cb4so4146350b3a.3
        for <dmaengine@vger.kernel.org>; Sun, 21 Dec 2025 21:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766380221; x=1766985021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HXbQkXLbPCcnMf8qSQ3UYnKPQBMFv/tHJAxobOvHBqU=;
        b=dvhd1clY4TZ3Jab8Moyv1//EOxiNKiYzM0FMHh9PA+ptGyaJ47RbeQMm6dAaSohxMc
         7QLDrS0+JZ3wmHh6hqf/DDJEo+OWI2IaHdne6x8p4cFaWsku0ma7c0rQomRAyfvzDO/F
         JkJGszz82HlbusbRQB/+z3WaRNQ5YYSSqc4KZQs+ojBY07ejxfWANGISgEjcsdQrSdWo
         iJo4FCbYY/gBbfwyB6WcOJTAI7yhWxwEVf3+1PnjdBE5HcLjXRpMayBKJneQr706fQ+3
         KupFLoVg9YGAeMw0JhDPsI54gl6hmevoNm0zdIQCcwUxJ4HjbFkg0fUcHLIVWAysIwZj
         5xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766380221; x=1766985021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HXbQkXLbPCcnMf8qSQ3UYnKPQBMFv/tHJAxobOvHBqU=;
        b=Q9wzqEw1WB043rPCWPuPEES9wm9B0L7vB+FyEZ78swpQz7bYcS1BlNX2cOvSCT3893
         VLDbLorw0gXWoOdQebSTaWPfQ9eFVfxZ/k5P0gw/58EBdXWCo+XITAnoL8OSuTCFEOKc
         FHN2GJ4ffkIw4MypLnIAVFBq4IeicQGrEi6zM3i0kewIiwLWMgYg+Sy+uBmGaAehrSqs
         gLbRSmI8keTR3xOKLoNu9lcgH6f9bjMiostsy1qEHw8DR5/FjX7aplJzblv2amRll44G
         PkrANMsZBr6YBk35FeQ+Nys32rJqYUHnCgYHU0M0GRz7mOGZYbUcKiGkmt8FIGYEraH1
         wNGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt/PcUtAtNewRdIufkix3ooYRfSrtTdtYcBNY6y7nX87GgRPAD24hngbVGG+4UnQOnU9R3buiUEX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxcYg+e8C4Sp4ZWNkrNOpG1bzMaEK/4GijDSY9NWudJc97SbuH
	5r43bbaf/nALhexZp++TdKmMwOuO1MpLT+Zjfp9N3Q2qdzSFNzmb8QhHnp11aJ3ktMAc6tIrS31
	y+3IWKxCflI2UK6nyBR/TSWI3ArGW5YIoCwJBEzhC3N6KMZFF5bIM1m9qeWYuP8k=
X-Gm-Gg: AY/fxX53W5R2NNZQGzs/0R/C+1BnSpJ9wnsAqAUp0zwSPSeWdeRzLvVQEt9U+mwZ52f
	980L/wl1gxxBW8Kv4zM6zvpq7Q9H2avS6bIegqGGMA8Wp5fOW00SWfznUTfavqAhBmTA0DBQOIW
	g7dPPQ1mYNGbxtLpb4lmP7I+Ck/lW/WQclZEo3h9tWUpUTj/j30n11aY4PWvwm76xdniqxxMm60
	+XcTuIhcda4idDKq3VU1tDZDEhtPjIwCC+ixGJxMstFOTeeBHyvjGbLDWdAWJdtxqzHiWeLRmtK
	+gpzmKoUomVSGUi9V70uCGOQkig+14A1453/USj7gUMITlaU+77gI4WnT8f8UkNMkwFjjsMPoic
	1KeJIkke1MHLoML8KJrhP4VQ+/VJHs3Vj/t6fgf7dYg==
X-Received: by 2002:a05:6a00:300a:b0:7fb:e662:5b9 with SMTP id d2e1a72fcca58-7ff65b89e90mr8924682b3a.31.1766380221446;
        Sun, 21 Dec 2025 21:10:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFpOv39fyYe3Y6DO36gLzXz15wWvy6fF5eZcOkSsJ9t+fQWdknuEDuZFFuexgvKPURThzOzQ==
X-Received: by 2002:a05:6a00:300a:b0:7fb:e662:5b9 with SMTP id d2e1a72fcca58-7ff65b89e90mr8924636b3a.31.1766380220877;
        Sun, 21 Dec 2025 21:10:20 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac29bsm8894204b3a.39.2025.12.21.21.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Dec 2025 21:10:20 -0800 (PST)
Message-ID: <4909f70a-2f65-4cac-96ac-5cd4371bc867@oss.qualcomm.com>
Date: Mon, 22 Dec 2025 10:40:12 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 19/27] PCI: dwc: ep: Cache MSI outbound iATU
 mapping
To: Niklas Cassel <cassel@kernel.org>, Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Frank.Li@nxp.com, mani@kernel.org,
        kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
        corbet@lwn.net, vkoul@kernel.org, jdmason@kudzu.us,
        dave.jiang@intel.com, allenbh@gmail.com, Basavaraj.Natikar@amd.com,
        Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com,
        logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org,
        robh@kernel.org, jbrunet@baylibre.com, fancer.lancer@gmail.com,
        arnd@arndb.de, pstanner@redhat.com, elfring@users.sourceforge.net
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-20-den@valinux.co.jp> <aTaE3yB7tQ-Homju@ryzen>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <aTaE3yB7tQ-Homju@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JuH8bc4C c=1 sm=1 tr=0 ts=6948d2be cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=9AdMxfjQAAAA:20 a=lh4N-NlUUnQL023WPUYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: khEqb9TNW2d6OiaGCHj9u-R4a603_AUY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDA0MyBTYWx0ZWRfX8sHSwn4Qv8RS
 ZMnE45xPM1N2OkBttC7ByX3lp2pHFUfogDoG82h/yFAveryXY1O8zlzBFt9cHJreRibOo+9PvSb
 mH4vpg++gO4yxCi55hA37vkvhJZoQhK4Zl2PYDZIompB36H++mhpl4ONZ7u1EYphYhdHGRnoROh
 /z1TLW3Pwr7O4YiRYczxIyIOg/YtxCBykjIBaBL3uGjYwdfqnL+xV9DuKPt1IzsgqapsNluJ/o2
 xKIK4WVvLx97yg6JnC+yOQbrfGAGog0QIkuWrlA8TJ2ho1MMcKnjb5/wGzwr9uBdokOGQoybn0h
 9n/PXjatYM10CwJYbaMSs9rw+kor4h85nBx2veFfE3qEq5rsdpCqcdwIOve0e+aIgMLlDGLo9Yx
 dLbGqn/aL2Xo+vvqN3A4I2ygGK2nnsfz7pSTfZOxpinYF4NcXLer1/2faMgEuXeBsWYD3iSLgMG
 1SFUM0n+g5VmKNfhDDw==
X-Proofpoint-GUID: khEqb9TNW2d6OiaGCHj9u-R4a603_AUY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512220043



On 12/8/2025 1:27 PM, Niklas Cassel wrote:
> On Sun, Nov 30, 2025 at 01:03:57AM +0900, Koichiro Den wrote:
>> dw_pcie_ep_raise_msi_irq() currently programs an outbound iATU window
>> for the MSI target address on every interrupt and tears it down again
>> via dw_pcie_ep_unmap_addr().
>>
>> On systems that heavily use the AXI bridge interface (for example when
>> the integrated eDMA engine is active), this means the outbound iATU
>> registers are updated while traffic is in flight. The DesignWare
>> endpoint spec warns that updating iATU registers in this situation is
>> not supported, and the behavior is undefined.
>>
>> Under high MSI and eDMA load this pattern results in occasional bogus
>> outbound transactions and IOMMU faults such as:
>>
>>    ipmmu-vmsa eed40000.iommu: Unhandled fault: status 0x00001502 iova 0xfe000000
>>
>> followed by the system becoming unresponsive. This is the actual output
>> observed on Renesas R-Car S4, with its ipmmu_hc used with PCIe ch0.
>>
>> There is no need to reprogram the iATU region used for MSI on every
>> interrupt. The host-provided MSI address is stable while MSI is enabled,
>> and the endpoint driver already dedicates a scratch buffer for MSI
>> generation.
>>
>> Cache the aligned MSI address and map size, program the outbound iATU
>> once, and keep the window enabled. Subsequent interrupts only perform a
>> write to the MSI scratch buffer, avoiding dynamic iATU reprogramming in
>> the hot path and fixing the lockups seen under load.
>>
>> Signed-off-by: Koichiro Den <den@valinux.co.jp>
>> ---
>>   .../pci/controller/dwc/pcie-designware-ep.c   | 48 ++++++++++++++++---
>>   drivers/pci/controller/dwc/pcie-designware.h  |  5 ++
>>   2 files changed, 47 insertions(+), 6 deletions(-)
>>
> I don't like that this patch modifies dw_pcie_ep_raise_msi_irq() but does
> not modify dw_pcie_ep_raise_msix_irq()
>
> both functions call dw_pcie_ep_map_addr() before doing the writel(),
> so I think they should be treated the same.
>
>
> I do however understand that it is a bit wasteful to dedicate one
> outbound iATU for MSI and one outbound iATU for MSI-X, as the PCI
> spec does not allow both of them to be enabled at the same PCI,
> see:
>
> 6.1.4 MSI and MSI-X Operation § in PCIe 6.0 spec:
> "A Function is permitted to implement both MSI and MSI-X,
> but system software is prohibited from enabling both at the
> same time. If system software enables both at the same time,
> the behavior is undefined."
>
>
> I guess the problem is that some EPF drivers, even if only
> one capability can be enabled (MSI/MSI-X), call both
> pci_epc_set_msi() and pci_epc_set_msix(), e.g.:
> https://github.com/torvalds/linux/blob/v6.18/drivers/pci/endpoint/functions/pci-epf-test.c#L969-L987
>
> To fill in the number of MSI/MSI-X irqs.
>
> While other EPF drivers only call either pci_epc_set_msi() or
> pci_epc_set_msix(), depending on the IRQ type that will actually
> be used:
> https://github.com/torvalds/linux/blob/v6.18/drivers/nvme/target/pci-epf.c#L2247-L2262
>
> I think both versions is okay, just because the number of IRQs
> is filled in for both MSI/MSI-X, AFAICT, only one of them will
> get enabled.
>
>
> I guess it might be hard for an EPC driver to know which capability
> that is currently enabled, as to enable a capability is only a config
> space write by the host side.
As the host is the one which enables MSI/MSIX, it should be better the 
controller
driver takes this decision and the EPF driver just sends only raise_irq.
Because technically, host can disable MSI and enable MSIX at runtime also.

In the controller driver,  it can check which is enabled and chose b/w 
MSIX/MSI/Legacy.

- Krishna Chaitanya.
> I guess in most real hardware, e.g. a NIC device, you do an
> "enable engine"/"stop enginge" type of write to a BAR.
>
> Perhaps we should have similar callbacks in struct pci_epc_ops ?
>
> My thinking is that after "start engine", an EPC driver could read
> the MSI and MSI-X capabilities, to see which is enabled.
> As it should not be allowed to change between MSI and MSI-X without
> doing a "stop engine" first.
>
>
> Kind regards,
> Niklas
>


