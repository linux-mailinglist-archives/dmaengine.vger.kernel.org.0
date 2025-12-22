Return-Path: <dmaengine+bounces-7862-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C96CD4F0E
	for <lists+dmaengine@lfdr.de>; Mon, 22 Dec 2025 09:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23DD4300422F
	for <lists+dmaengine@lfdr.de>; Mon, 22 Dec 2025 08:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B3F30BF64;
	Mon, 22 Dec 2025 08:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gLS+j2GK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XAwzH/CS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148BD30BBA5
	for <dmaengine@vger.kernel.org>; Mon, 22 Dec 2025 08:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766391256; cv=none; b=EYTkcozh9A4ofJa46HH9YISlAkW/inleJHwm4s6g+JTHlETibuFDvBEdVJBQNsAM45tJkWuKy73Bad6pyvuhnyuwmzDyadGSXH4xDGWiYwX1B2wZeAJ5iGFrKtguCpcpr7yHJsezvTthB2DMEJGuVljgvaTQH8eAwiuAzT1hJCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766391256; c=relaxed/simple;
	bh=ug4yylwNcO90NJvpE3SC7VOMbFwgEshDUXvRfWQd9TY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MB2KZ20B6/yzCKVexYzeMY0dAPpZTtFgCAYvykwBxmfEZLHuik5aKEDfiJQpKdMfaheAF4OntOIxvkNlkwSMkbebTgjbuQfb9yqHXKwQXS+upk5QnVZKiLEOQQZc7cwPDT3F7bqLE4DDDn4gcm9ZvfG7LHRtLsXp1dTwtk09qgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gLS+j2GK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XAwzH/CS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BLMv9jl3808462
	for <dmaengine@vger.kernel.org>; Mon, 22 Dec 2025 08:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cbxoIvggTHwJGPAyfPp+mE9GnjxpExWzAQ+NnFf0Hcc=; b=gLS+j2GKE+o26XxJ
	09rshfZSMea52CyGG6s8CXRBs45zFtBLYGt1nTkJS/UukmbwGBe1rbkueX5WQWKh
	XINKSK5P6lmg1kvpW7ip+Sp0Y6JdPZK0VD0nG+7Gel9VQ7rhGHYOKfDgzm7CQw2u
	o5DtXyFS+XmYg3dba8o9BnTQ4AiYBjLKZ7Pf3qLqeOFMMggmpt0UcOfxIlgXKXhx
	KCpWN3BZcNomRwybcxiOJAM1z1q1YVH8LGixmpCnBo95tKys/ed6BiLmKR2Vbjm3
	eYpdOFaOLlnj9tYkLc4h3cpYKEkz6nAKk4UA9F61HJvMbvSdCEgQ2qUmWjSrpTK/
	3zvKiA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mru483q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 22 Dec 2025 08:14:13 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c6e05af6fso3896986a91.1
        for <dmaengine@vger.kernel.org>; Mon, 22 Dec 2025 00:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766391252; x=1766996052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cbxoIvggTHwJGPAyfPp+mE9GnjxpExWzAQ+NnFf0Hcc=;
        b=XAwzH/CSpJXg9AvP/SNFpd9RXjQ4mnIUxP05PGKfePsUHXIk0fGu1hW2MP37H7EyHb
         aWpGMGHHz+t0CoK+FqRFKUmiDo1NopchfnhjKMKokT3HuPEkw9+DXRBwZ2XlV+3ns8SA
         NzfmLnjCaD0tIXe6NSyn5jBjcbSORQ6R6w8ztOiq2FtmiQp72ywyKciVUHkImjjd95YI
         UAB1dZh3MNiA2ino4vnkwNg8pRG3ibOOXjA5j1VVmHcU04QCAxpvNK/6jSne1R52aKkd
         7JZj6c9bmyHa1l9ctQqJ4mYiVqD4p3TFpUZf/HGlmNPPMLnwUcPJWpR3vkS7Wf8DZd1R
         bzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766391252; x=1766996052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbxoIvggTHwJGPAyfPp+mE9GnjxpExWzAQ+NnFf0Hcc=;
        b=LKniKQzP3WOZ21f2UF1jrkWyxgTyN5PHVOsFj6uDrvfsld4+xYDyga16YcLY2VVW9z
         jCzraHM7Yz+b2v5NMZOCGsQJDhG8G6xgiWarJNsmTteuuO0hxxIg3198RaaIjkqo6jnP
         mlj9gH3Qh0WjeikrGR+yFUc3xn8FP6WX2sHEgngDyHZua9LGQSnyRuml8+yp7CC9nSRa
         Ja58CRciWis1zQZC2IpZ3MCC9UDLiukIM5zFRVI9QSCCVrDckK+cYRUh7EseTnW+NZkK
         GU++QApdt1O1UQ57lsbIaN9L6wTDrTOT+CcPWDL6e28V2zziyLlQdlwu8mL/7kTsLHuv
         ERVA==
X-Forwarded-Encrypted: i=1; AJvYcCUL46qE3nzeximFtwuNa5kXhzN3o/twckPTsvK9yJRYRDbVkpYw2T7UNgCizg8mbh0z7II66aicbpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz09Dwb84udY4tPTFQW33B++LZIK4parp0IGtd+UsbwFRi/t6VB
	Gc/85wn8VKHBeUKIZcd2ezRepjNMONIVAzW9du5mRReW2BGR3u8dgxIjz0/q68E5CAdvyRKY4F7
	PSGfAVYUlamR4ERg943420d7y12slNLIq6x5LwYFUuZBnzDjw/o0y7tIUSz5DZiw=
X-Gm-Gg: AY/fxX4E4GQYwpTA626wSBqH6eTGCbc+KfJOlm00XvObm8ggFMvWpEuQPF8O6awNjpi
	1O+1mYQ/IzQxk1cRPyUfs9FRCYZGsRCQdCMxb8Rv2UV1hCkIw223GOfC/tHPZW999cpGn//LhSo
	dxW/7h1O0imojhfU7FF+KETyrOhrf27n2R3bxdXdRD2s0NBhDlAa89K6LMANK2Zdn9VQhBemKhA
	ImaIcRzmq0tEaEbAya8Hi2OEWWBlOFMaK8kYwwxE4K7hsU0aYlHPbtJpWPu6Hee+x99Gg7CAWdN
	NFCs059K1rK/HFf/gZHA5FpMTNo4GJYP7i9v9tqCKEwnp5TR9q7z2NWD0rovYLDGHAlMSQ9V0tA
	3MUmMMMwmFvgAAe39J8W13vIwi4ku1jDJK0uBgEI9gQ==
X-Received: by 2002:a17:90b:1d83:b0:32a:34d8:33d3 with SMTP id 98e67ed59e1d1-34e91f749d8mr8077465a91.0.1766391252413;
        Mon, 22 Dec 2025 00:14:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1Go09mxe6FptC6uL4OomBUKer2vZ4FaNIffkFWpnND+g9IVqxiqRcg2zZV/2/WJ8KZ0XTqQ==
X-Received: by 2002:a17:90b:1d83:b0:32a:34d8:33d3 with SMTP id 98e67ed59e1d1-34e91f749d8mr8077421a91.0.1766391251826;
        Mon, 22 Dec 2025 00:14:11 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dbd618sm12166827a91.12.2025.12.22.00.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 00:14:11 -0800 (PST)
Message-ID: <a7b94f8f-8773-43b0-b481-29828aba9abd@oss.qualcomm.com>
Date: Mon, 22 Dec 2025 13:44:02 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 19/27] PCI: dwc: ep: Cache MSI outbound iATU
 mapping
To: Niklas Cassel <cassel@kernel.org>
Cc: Koichiro Den <den@valinux.co.jp>, ntb@lists.linux.dev,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
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
 <4909f70a-2f65-4cac-96ac-5cd4371bc867@oss.qualcomm.com>
 <aUj4M3z87MwFSUFW@ryzen>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <aUj4M3z87MwFSUFW@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDA3MyBTYWx0ZWRfX28td5LjqKxU9
 UVYt7gfA+/Rv6PVOctQjEUlGw7GtmJw4VIdH2PnhShQfgGFLij4JUq1T0EDt1V48v57mUvyMr2l
 DVTr8slyrkMW4lguDx1biljs/R5EDmFmwL7A7eBLDTJG9LWnC+U8V6oI2icC2qdzMVPR0K8jS5a
 Oj61d3HqLYxjdMxFkUQJRW0iF7Km8InlN4ljGq30KDMHUAv0xDN1M7RFdccMp0bupq0BsZx26OF
 V0BZxW3ukBmcDbbLGTIgvaQ/lkj1UQ42Ap5XKXGuJsd2WqSlH+hAoZzrwa1ak+bPq1JWrV76R9s
 cdulCgZr3rsGgMDV/mAMVC+bp1TcZwiJeha2fZV1b1gX+rSZLwIvWpvUQ2qIX87A3rtet82+CXo
 u6aOSiY4GYUj9hQKSaSBrVPVb7hD10ec2rBai80c/XpjCi+9vyxICAREsQacETLzSAeVSGbWp20
 govOVmCsT1iWqCxgNkg==
X-Authority-Analysis: v=2.4 cv=VMnQXtPX c=1 sm=1 tr=0 ts=6948fdd5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=9AdMxfjQAAAA:20 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8
 a=XlojDObrNaimPXCU0dcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=d3PnA9EDa4IxuAV0gXij:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: cpiAabBllmwtaXySW2WUUeFzvPk_4csE
X-Proofpoint-GUID: cpiAabBllmwtaXySW2WUUeFzvPk_4csE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512220073



On 12/22/2025 1:20 PM, Niklas Cassel wrote:
> On Mon, Dec 22, 2025 at 10:40:12AM +0530, Krishna Chaitanya Chundru wrote:
>> On 12/8/2025 1:27 PM, Niklas Cassel wrote:
>>> On Sun, Nov 30, 2025 at 01:03:57AM +0900, Koichiro Den wrote:
>>>
>>> I guess the problem is that some EPF drivers, even if only
>>> one capability can be enabled (MSI/MSI-X), call both
>>> pci_epc_set_msi() and pci_epc_set_msix(), e.g.:
>>> https://github.com/torvalds/linux/blob/v6.18/drivers/pci/endpoint/functions/pci-epf-test.c#L969-L987
>>>
>>> To fill in the number of MSI/MSI-X irqs.
>>>
>>> While other EPF drivers only call either pci_epc_set_msi() or
>>> pci_epc_set_msix(), depending on the IRQ type that will actually
>>> be used:
>>> https://github.com/torvalds/linux/blob/v6.18/drivers/nvme/target/pci-epf.c#L2247-L2262
>>>
>>> I think both versions is okay, just because the number of IRQs
>>> is filled in for both MSI/MSI-X, AFAICT, only one of them will
>>> get enabled.
>>>
>>>
>>> I guess it might be hard for an EPC driver to know which capability
>>> that is currently enabled, as to enable a capability is only a config
>>> space write by the host side.
>> As the host is the one which enables MSI/MSIX, it should be better the
>> controller
>> driver takes this decision and the EPF driver just sends only raise_irq.
>> Because technically, host can disable MSI and enable MSIX at runtime also.
>>
>> In the controller driver,  it can check which is enabled and chose b/w
>> MSIX/MSI/Legacy.
> I'm not sure if I'm following, but if by "the controller driver", you
> mean the EPC driver, and not the host side driver, how can the EPC
> driver know how many interrupts a specific EPF driver wants to use?
I meant the dwc drivers here.
Set msi & set msix still need to called from the EPF driver only to tell 
how many
interrupts they want to configure etc.
>
>  From the kdoc to pci_epc_set_msi(), the nr_irqs parameter is defined as:
> @nr_irqs: number of MSI interrupts required by the EPF
> https://github.com/torvalds/linux/blob/v6.19-rc2/drivers/pci/endpoint/pci-epc-core.c#L305
>
>
> Anyway, I posted Koichiro's patch here:
> https://lore.kernel.org/linux-pci/20251210071358.2267494-2-cassel@kernel.org/
I will comment on that patch.
>
> See my comment:
>    pci-epf-test does change between MSI and MSI-X without calling
>    dw_pcie_ep_stop(), however, the msg_addr address written by the host
>    will be the same address, at least when using a Linux host using a DWC
>    based controller. If another host ends up using different msg_addr for
>    MSI and MSI-X, then I think that we will need to modify pci-epf-test to
>    call a function when changing IRQ type, such that pcie-designware-ep.c
>    can tear down the MSI/MSI-X mapping.
Maybe for arm based systems we are getting same address but for x86 
based systems
it is not guarantee that you will get same address.
> So if we want to improve things, I think we need to modify the EPF drivers
> to call a function when changing the IRQ type. The EPF driver should know
> which IRQ type that is currently in use (see e.g. nvme_epf->irq_type in
> drivers/nvme/target/pci-epf.c).
My suggestion is let EPF driver call raise_irq with the vector number 
then the dwc driver
can raise IRQ based on which IRQ host enables it.
> Additionally, I don't think that the host side should be allowed to change
> the IRQ type (using e.g. setpci) when the EPF driver is in a "running state".
In the host driver itelf they can choose to change it by using 
pci_alloc_irq_vectors 
<https://elixir.bootlin.com/linux/v6.18.2/C/ident/pci_alloc_irq_vectors>, 
Currently it is not present but in future someone can change it, as spec 
didn't say you
can't update it.
> I think things will break badly if you e.g. try to do this on an PCIe
> connected network card while the network card is in use.
I agree on this.

I just want to highlight there is possibility of this in future, if 
someone comes up with a
clean logic.

- Krishna Chaitanya.
>
>
> Kind regards,
> Niklas


