Return-Path: <dmaengine+bounces-9236-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOHkDh8PqGk8ngAAu9opvQ
	(envelope-from <dmaengine+bounces-9236-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 11:53:19 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1571FE911
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 11:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE8B73035BEA
	for <lists+dmaengine@lfdr.de>; Wed,  4 Mar 2026 10:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1093A256E;
	Wed,  4 Mar 2026 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fXjiiJ1W"
X-Original-To: dmaengine@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azhn15012013.outbound.protection.outlook.com [52.102.136.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1826739F19E;
	Wed,  4 Mar 2026 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.136.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772621587; cv=fail; b=rlmW45W+1RCL9a/Y1ExRnc9UPgftHWmZvJAq/DgXv+nFDVD94PHuBsV2EJ7aFW91EoAtJRQQP1vuNeJmA0v5EVYHQoYKFKPE+wDHQhJ4e0+Ftk+kjjh4Dr+rT0Nr+/0Wi1GDK1uYTQiE0xq9xfayQmluNmDL2M+qpbDwpqd6Wy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772621587; c=relaxed/simple;
	bh=G34V6iDa1J3hKbBWhIQ4euSSvn4ClRmwKaW7dbGGXLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nG6JNMRlB2n/qXHV4TYEM14Y6SNgRnsbSk3Jizea6zcBW9RS4YYSmUNQM0C5cNuyCV/boV6/d6OXd42JHXY1ziAcgAC6i5hj8QlWPTeNk0VGvi/5Dclz9IK9w767ZnzoERQ4Zx8y5XShgDA4L23DFveQzf7AMoasvkICQwTBXkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fXjiiJ1W; arc=fail smtp.client-ip=52.102.136.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOb7vdetBdH+4IIaSgat5Sr8pufpInqdI2CHcFHv6NJn737o+5+QPMQb1WcCA/MiCnFknvXx/kF/GYhO2jhf1O10P3nU10BBI4aiEANzWgnDcf+xZRgsxjLDWgB6x07KmkE7td+FZXX9ejiar+AcTQ3oMxI0fifDfYFqHchOAI7k3uKQLKulUvVHiM4hSaqWSLjmKXQkxFeCSlfd1OKpk67qkavSE+zfR2O0mFbUkkZDMC7tJ+cXg7nsJgvPqITTPh6VhX0blxuQq2dlPRUBZAoBDoBGUk8zIvpHwPk2VAqvhr7ocUIBe5PTn9WPHC7YG2Zq6m/25sdOMjmgwhilcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVRhkMntvBj+ZtEISffIKDRtcWm8X5Uln6JMGzYgrxI=;
 b=NGlCdq/KvbjyusgFaITB/r7WiP6Epgmr/8Fmny2lvrUz4NjU/pFBIR3y1SSTotXvXJPLrKR8oP5uc0fvj2DGBpfj9pS2e+vQsnxgLCPrbPA+06ngDnUVGX/pAU2l64P4+fOIyYxCc6oGBGdtc8BAVePYz6vIikbn59W5gKR3D0WfwkLcv1pmmTpq9tMV4ih9H1ZU6c3G+Wk65HXRrYqMBdC1k5jZMG625pNvxm1ckR+y5YSReYWfCOWEKv8KWoNfazkrTpbY/isaDfo1NKeZhmIqqdF4sfJPHQxDhIf1ODFh5s/8kPDCpT7W5QzhhIPSGbBpPzi2PLc97frR6xo3JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVRhkMntvBj+ZtEISffIKDRtcWm8X5Uln6JMGzYgrxI=;
 b=fXjiiJ1W9k67eOGBjuZ/2mXHsqi5sLhTU4JztIGAlVSnFjok3Ieqvy8zo6NJZ4bKlek3I9LznCLozxsqAxjBIHfgcOX+9RhNGuU30xroN0z8ziaX7dUrkFI7Kw1S/rHd1Zq+/+nSCXV4+3h0hcizl2Ui74swpnBmd6KfGt2gqDQ=
Received: from IA4P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::11)
 by PH7PR10MB6284.namprd10.prod.outlook.com (2603:10b6:510:1aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 10:53:00 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:559:cafe::31) by IA4P221CA0009.outlook.office365.com
 (2603:10b6:208:559::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Wed,
 4 Mar 2026 10:53:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 10:53:00 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Mar
 2026 04:52:59 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Mar
 2026 04:52:59 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Mar 2026 04:52:59 -0600
Received: from [172.24.233.239] (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 624Aqtdr229809;
	Wed, 4 Mar 2026 04:52:55 -0600
Message-ID: <e1d07c8a-a90d-444a-a367-230f147e01d6@ti.com>
Date: Wed, 4 Mar 2026 16:22:54 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/18] dt-bindings: dma: ti: Add K3 BCDMA V2
To: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, <peter.ujfalusi@gmail.com>,
	<vkoul@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
	<Frank.li@nxp.com>, <r-sharma3@ti.com>, <gehariprasath@ti.com>
References: <20260218095243.2832115-1-s-adivi@ti.com>
 <20260218095243.2832115-13-s-adivi@ti.com>
 <20260219-hopeful-intrepid-cuckoo-32967d@quoll>
 <bab85365-063a-4d46-a1bf-48a25228d109@ti.com>
 <20260223182057.GA4190282-robh@kernel.org>
Content-Language: en-US
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
In-Reply-To: <20260223182057.GA4190282-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|PH7PR10MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: 57877341-e2f5-4c16-ffea-08de79dc33f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|34020700016|36860700016|12100799066;
X-Microsoft-Antispam-Message-Info:
	/7cY+Dw3bX7ueJZK85vEA6cw2y0+4qIAV7n3dVbSt08l8DHDS/+U09zR/nAlKQDzCD0pp5Qyq2HDndUKkPr5gC0pL4Hei8xIAHZcQQe/Us0focuTGcQXah1uRRxDb+xvv2XVA0QqXBP9/2byhFxwhFxYXtimMUkDqfYurV1R7tMo6pxKKRzL4ys0OhQWaLJdD5m7eet6MmAX6I1PJmuoeI+/M+Y5bPj89y8LWpyOnr8oK3tlB5iGTs54dgbcTaCpO50HE5nQYEVQIyblee8duiQcwwb9VzPIlLf/+BYcN0b7gJDWnEop8Agoibtmt7silhPRJd6oOwJK/vbt1jiHHk/8Lj+rEUJJsYHCyZDbGR++siPHJIog9kNbH7VCVxYB5ATenfA9dswlMFzsSQ5L7Q+GkHpjuGMoSgm3OR2Qu/ivPR8LMZd+iT2O58nfBumVfT7esO24R1wix63fRK8L0cyVFOUoiyQJGeQG7vwi8ug1YQTfJWTyTKCrlzxl6QoZr/lOU4dQjIMznZVjgZD0PtNF5UB+lkpU2UujMaHlBioqD8pBZS1PxzJGVV149znJ4P7E7X4SPHDYcbXdtKSGGzPv564/2DmagA+8p0l6UbnH4Y2n7s+E052vU3npTbKykmouicWQ0GrU3iYuU5oI6Q0T57k7i6X7mi2efyTLmUovtKkQ8XhEJHRkyHGmrZk+ab7SumEhwXIV+x807V6Ypk0ip/Kl5uv5zkiFCvjuxCM=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(34020700016)(36860700016)(12100799066);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	08VgGqRQ2D+tGAc07wwvb8nDcsv+FcxrM7j14Q7090WcEx6QSwdBQ9L4N6E+jp7PNrcl3JsDWYk7Huf3fAkibS0l5u5VcJrIp/n7oMdFErso2S5XlPkGAJsFaeVWC6gLhwta90VTCaP8vHCuFm6HZVOymq99WlHoKltml6dlBXwSuNTMNQ/jfXAhFYyfLtfcUFoskTKBp6g2DTeClR3/z84BDZzzWtZ+dC7Ig9am5EjJWe/iyoYkpWhU13EmwjA3QGM/TLD/0G6oUOoBhq3Ar0XvwhD1PxWD641vFpx5noMKyekhRX5vAQfupa+wIvEGSA0QoXyJ6/qxiU3I+v2GwzzugvWe99Yh/Y9pxgo+wFyZ3a3/LYfu6O8BSUBOCTGNbnP344TeyPMNVGSUCB1hY8tmhJ7clKI1sCk9NIJnvqpkEkIrQI/DJL4OgSIvwZ6v
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 10:53:00.3721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57877341-e2f5-4c16-ffea-08de79dc33f9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6284
X-Rspamd-Queue-Id: 9C1571FE911
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9236-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action


On 23/02/26 23:50, Rob Herring wrote:
> On Thu, Feb 19, 2026 at 05:45:46PM +0530, Sai Sree Kartheek Adivi wrote:
>> On 19/02/26 13:13, Krzysztof Kozlowski wrote:
>>
>> Hi Krzysztof,
>>
>> Thanks for the review.
>>> On Wed, Feb 18, 2026 at 03:22:37PM +0530, Sai Sree Kartheek Adivi wrote:
>>>> New binding document for
>>> Fix wrapping - it's wrapped too early.
>> Ack. will fix it in v6.
>>>> Texas Instruments K3 Block Copy DMA (BCDMA) V2.
>>>>
>>>> BCDMA V2 is introduced as part of AM62L.
>>>>
>>>> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>>>> ---
>>>>   .../bindings/dma/ti/ti,am62l-dmss-bcdma.yaml  | 120 ++++++++++++++++++
>>>>   1 file changed, 120 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml
>>>> new file mode 100644
>>>> index 0000000000000..6fa08f22df375
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml
>>>> @@ -0,0 +1,120 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +# Copyright (C) 2024-25 Texas Instruments Incorporated
>>>> +# Author: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/dma/ti/ti,am62l-dmss-bcdma.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Texas Instruments K3 DMSS BCDMA V2
>>>> +
>>>> +maintainers:
>>>> +  - Sai Sree Kartheek Adivi <s-adivi@ti.com>
>>>> +
>>>> +description:
>>>> +  The BCDMA V2 is intended to perform similar functions as the TR
>>>> +  mode channels of K3 UDMA-P.
>>>> +  BCDMA V2 includes block copy channels and Split channels.
>>>> +
>>>> +  Block copy channels mainly used for memory to memory transfers, but with
>>>> +  optional triggers a block copy channel can service peripherals by accessing
>>>> +  directly to memory mapped registers or area.
>>>> +
>>>> +  Split channels can be used to service PSI-L based peripherals.
>>>> +  The peripherals can be PSI-L native or legacy, non PSI-L native peripherals
>>>> +  with PDMAs. PDMA is tasked to act as a bridge between the PSI-L fabric and the
>>>> +  legacy peripheral.
>>>> +
>>>> +allOf:
>>>> +  - $ref: /schemas/dma/dma-controller.yaml#
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: ti,am62l-dmss-bcdma
>>>> +
>>>> +  reg:
>>>> +    items:
>>>> +      - description: BCDMA Control & Status Registers region
>>>> +      - description: Block Copy Channel Realtime Registers region
>>>> +      - description: Channel Realtime Registers region
>>>> +      - description: Ring Realtime Registers region
>>>> +
>>>> +  reg-names:
>>>> +    items:
>>>> +      - const: gcfg
>>>> +      - const: bchanrt
>>>> +      - const: chanrt
>>>> +      - const: ringrt
>>>> +
>>>> +  "#address-cells":
>>>> +    const: 0
>>>> +
>>>> +  "#interrupt-cells":
>>>> +    const: 1
>>> I don't get why this is nexus but not a interrupt-controller.
>>>
>>> Can you point me to DTS with complete picture using this?
>> Please refer https://github.com/sskartheekadivi/linux/commit/4a7078a6892bfbc4c620b9668e3421b4c7405ca4
>>
>> for the dt nodes of AM62L BCDMA and PKTDMA.
>>
>> Refer to the below tree for full set of driver, dt-binding and dts changes
>>
>> https://github.com/sskartheekadivi/linux/commits/dma-upstream-v5/
> Whether this is an interrupt-map or a chained interrupt controller 
> entirely depends on whether the interrupts are transparent to the 
> DMA controller (i.e. do they have to be acked?). interrupt-map is 
> generally for transparent cases.
>
> If not transparent, then just 'interrupts' and 'interrupt-controller' 
> should work for you. You can map 'interrupts' entries to channels like 
> many other DMA controllers do that have per channel interrupts.

Thanks for the clarification, Rob.


To answer your question: the interrupts are definitely not transparent. They

have to be explicitly acked by writing to the BCDMA registers.

Given that, interrupt-map is the wrong approach here. I'll drop the nexus

properties and figure out the best way to map the per-channel interrupts

using standard interrupts in v6.


Regards,

Kartheek

>
> Rob

