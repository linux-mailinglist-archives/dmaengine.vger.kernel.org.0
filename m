Return-Path: <dmaengine+bounces-10505-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGASAyHQCmru8QQAu9opvQ
	(envelope-from <dmaengine+bounces-10505-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 10:38:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6479D568FBD
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 10:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CEEC30221E0
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 08:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090313E2ACD;
	Mon, 18 May 2026 08:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GWRPL/Si"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011066.outbound.protection.outlook.com [52.101.57.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227C83E2AC8;
	Mon, 18 May 2026 08:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779093415; cv=fail; b=FVXvJ0XkItmYdRVwDAhOQGrOG2o2h1TBZ5M46TdJH9E6JU7z4eoXaLnhro8FefbQLY/PSTVK8pUkwHIBZcayPRvKbOTPTKomOBiUZ4pB/KxCqhLklsfUHT+YV6DgEjpjIrxSrBe+IZEQKy9s02MttZYK9pj4i1XV7ADvd0WCjxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779093415; c=relaxed/simple;
	bh=/Og1lG8pR4sY+kftidFkIp1heQMONf1Mvocs0/KEl1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=anM9rTzwYIDnVHFZ0Oofb9P5FP1QccZU09D0VklfQWlFE8QQml0c29myLDIsf6M8b51iUt/LlgWmsDyA4OJn6JPAgeeof706trrS6hFRQoyPybQvKhoeUGDV8KLLkI/6qK6tb2T87m5/JFbwMX3bNqYYHgNt7BPG9qyTZqJrpVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GWRPL/Si; arc=fail smtp.client-ip=52.101.57.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/esTwh6L7r9YOItUyUnUmrnAqD6Ti9rzyK4rN1qeUDTqGTw/vQGoo96jg70ELFaPLNAa/XzTGmaLpIQ9gtTshOlibg0qAnQHg8NBvXNE7VfL+93pY2YXlRlKOfddFSSgnQW+h3vgu+FEWCExc+FzVJgpVPnQMx93zjwTUeU71UYL/4BPshWQs5xp/E91HVEhm8PwSnPEh+YuVy+EzzrzWSaF7hflinGpSmF/fHE8hphgEyt5tSByBU3tN2mSpG8Xqggfm268NJVM8SMarvTJTDiY8Dj2CkB/eXcjTKoZAkhQReJlB9AqWi0Jn6DFdnnRUJ//68KYitC/D0IJDiP2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7A3Z8+5ib0bemV2lf5nKz3AkYhvzY/84byhmcRUt9rM=;
 b=YPc+rEJfgznY/lOy+gakzJijPnIhMXhUl4aMu3vgX5+6fqcwuETaut4QuOR4Jn/XvxUq4M67DPxUhnlbEbGh8hKf/Vr5sKXZHcXZUB9fa3JSs8L3qp0E9JWYMpRp39l2DgVBLbbpRffZy+8Rm11k4AnjKOlOeyeUEDpEavfirLq49bGkbwR9YaXVkBtEFPjjwC5iOGVpKXI+ApL5ZZ/Il9ie34DGIh87RchApIvLyAsgSGqovfAQSFfQPac/txEqQmTz7l3Pa29R236mLHomsykzdsmekwgDPefY9Vis/XT9Z2aMutL8klCoDNWQTlhrdwfELR8TFk3d5osTr8MIJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7A3Z8+5ib0bemV2lf5nKz3AkYhvzY/84byhmcRUt9rM=;
 b=GWRPL/SixVVnK88PnLx7kErOAgMh7n8Y9Kf0HdrgB7EvKAxvQbuXLt6v0Xi5DzuQ0t41R/dbej2kK9I4zCvOt8yg8IuyJ0/WHKN8Pqa+8bI+m5PrkhoeO69iOexBqololOD1bEQ2puRIC8Fb4CCGo+zyykPL4C5pRURTa8gx5r0=
Received: from SJ0PR03CA0133.namprd03.prod.outlook.com (2603:10b6:a03:33c::18)
 by DS7PR10MB5037.namprd10.prod.outlook.com (2603:10b6:5:3a9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 08:36:49 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::a4) by SJ0PR03CA0133.outlook.office365.com
 (2603:10b6:a03:33c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 08:36:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 08:36:48 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 18 May
 2026 03:36:47 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 03:36:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 18 May 2026 03:36:47 -0500
Received: from [172.24.233.239] (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64I8ag7D1503492;
	Mon, 18 May 2026 03:36:43 -0500
Message-ID: <a90cb680-02aa-4630-9992-68788603800e@ti.com>
Date: Mon, 18 May 2026 14:06:41 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/19] dt-bindings: dma: ti: Add K3 BCDMA V2
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
	<Frank.li@nxp.com>, <r-sharma3@ti.com>, <gehariprasath@ti.com>
References: <20260428085202.1724548-1-s-adivi@ti.com>
 <20260428085202.1724548-14-s-adivi@ti.com>
 <20260430-orthodox-athletic-agama-be4111@quoll>
Content-Language: en-US
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
In-Reply-To: <20260430-orthodox-athletic-agama-be4111@quoll>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|DS7PR10MB5037:EE_
X-MS-Office365-Filtering-Correlation-Id: 466c9c78-9fef-4b5f-4422-08deb4b899e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|18002099003|22082099003|56012099003|4143699003|3023799003;
X-Microsoft-Antispam-Message-Info:
	pdpVpWmflqPBVODUXDF2tcULbtZD7EYQl9xwONFPb7Dwa5eyp9P8Ulm6KbjRFo3NI7VDYTI2uhWavqrVgJ9ffJQcJJL55Ml2GKgObNzJ1XGuyarB8pQr3WdT+l7irZmIK1tDwFvCRNvKPf43BHdJPasG6tEt3/0j5HIMuAZIuyQx06aDkEDxmG1i9bT3E37QvZMUuweCCqlNwQilD6R6zjTY7eMgpNQ2cDH/dKG2HmkI2ck8CLLCYrUxuTWNnCjw9GYLizPkmBNHp4Oe8A/rZbwzv0nlGlg5xd5VasSUQj3qBsz83/wcgRDpcsKdzrjA/7wNFOYJqa1mLSSWqMmX2coBYiYuvC96GcEy7pQk3l9sPNY25y4gIc8NUh2w+Vuk71XwlVlzLsTMRWIaJCBbYFBxqhF1E7pKXEYlzORZDxko7Gi2tGw0kUgRRubcheP7vN3GovHMXCGKX6FVJRupzm4zcqYncPRi/ZSIQn/lvS3pINjEO4XuH8K3xjC5zC0k5FFGpPoQ3uDd21wlIvs0z/2BXrOQtP4H7IMt5X5FXzIbqthS5dUgTprrLzhYcBbE1akweh4mBoF3xBLXK2KFh6yGP3CzDNdpG6ghte6GSjsh2SVhqdIE800sY0V+ERsd6incvg49vOL2khO+ObGXgP5hFm5fdoNbQD5NBBIRZiLDj2CCkDqTOEO7vqm9GMd2
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003)(4143699003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	b6tiDtIm97YYnEzLxYfVJqHrFr3E8E23bM7iXpe69ts8jmC1PTvob4K4HkBlpCjQK5uibFv5JcWFbns+jSAW6KtBp/vLEQPV1V/itUiva7zH5GdHz2D79ozBOD71PsAYKyn6rnX7saeusXfHacFQsbMdhH8axZWk+naqTb5FqOmW5Qs22oU6/Uhrg02E9E2rKXUY0Z7CAFwW/7VHoi9jdEUYKYMNvaRR9ZryFS6VxMVpv+ArucDI3MUfc03E2fzXk32gCFi4sK6myYVGXCMKYDru51+ODv8YLlOGUUB8lKXn89bhQgNz+N9kvBqrilynnBmyE6Q0Hdpw3PznyOITLUkVo6RQcPm3p7+PD/Q3AwYXBm5xZAgjO7IdwiBOUDA7VzGdwVNIO1LlVVKZkfwxyF7ng6elJxmYV2kyLg1Nzdb80MaNV7MVbtP333CeMP5m
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:36:48.0866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 466c9c78-9fef-4b5f-4422-08deb4b899e7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5037
X-Rspamd-Queue-Id: 6479D568FBD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10505-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:email,ti.com:mid,ti.com:dkim,devicetree.org:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

Hi Krzysztof,

On 30/04/26 12:59, Krzysztof Kozlowski wrote:
> On Tue, Apr 28, 2026 at 02:21:42PM +0530, Sai Sree Kartheek Adivi wrote:
>> New binding document for
> I don't see improvements.
>
>> Texas Instruments K3 Block Copy DMA (BCDMA) V2.
>>
>> BCDMA V2 is introduced as part of AM62L.
>>
>> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> ---
>>  .../bindings/dma/ti/ti,am62l-dmss-bcdma.yaml  | 121 ++++++++++++++++++
>>  1 file changed, 121 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml
>> new file mode 100644
>> index 0000000000000..28dcfce5633ce
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/ti/ti,am62l-dmss-bcdma.yaml
>> @@ -0,0 +1,121 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2024-25 Texas Instruments Incorporated
>> +# Author: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/dma/ti/ti,am62l-dmss-bcdma.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments K3 DMSS BCDMA V2
>> +
>> +maintainers:
>> +  - Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> +
>> +description:
>> +  The BCDMA V2 is intended to perform similar functions as the TR
>> +  mode channels of K3 UDMA-P.
>> +  BCDMA V2 includes block copy channels and Split channels.
>> +
>> +  Block copy channels mainly used for memory to memory transfers, but with
>> +  optional triggers a block copy channel can service peripherals by accessing
>> +  directly to memory mapped registers or area.
>> +
>> +  Split channels can be used to service PSI-L based peripherals.
>> +  The peripherals can be PSI-L native or legacy, non PSI-L native peripherals
>> +  with PDMAs. PDMA is tasked to act as a bridge between the PSI-L fabric and the
>> +  legacy peripheral.
>> +
>> +allOf:
>> +  - $ref: /schemas/dma/dma-controller.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: ti,am62l-dmss-bcdma
>> +
>> +  reg:
>> +    items:
>> +      - description: BCDMA Control & Status Registers region
>> +      - description: Block Copy Channel Realtime Registers region
>> +      - description: Channel Realtime Registers region
>> +      - description: Ring Realtime Registers region
>> +
>> +  reg-names:
>> +    items:
>> +      - const: gcfg
>> +      - const: bchanrt
>> +      - const: chanrt
>> +      - const: ringrt
>> +
>> +  "#address-cells":
>> +    const: 0
> Why do you need address-cells?
>
>> +
>> +  "#dma-cells":
>> +    const: 4
>> +    description: |
>> +      cell 1: Trigger type for the channel
>> +        0 - disable / no trigger
>> +        1 - internal channel event
>> +        2 - external signal
>> +        3 - timer manager event
>> +
>> +      cell 2: parameter for the trigger:
>> +        if cell 1 is 0 (disable / no trigger):
>> +          Unused, ignored
>> +        if cell 1 is 1 (internal channel event):
>> +          channel number whose TR event should trigger the current channel.
>> +        if cell 1 is 2 or 3 (external signal or timer manager event):
>> +          index of global interfaces that come into the DMA.
>> +
>> +          Please refer to the device documentation for global interface indexes.
>> +
>> +      cell 3: Channel number for the peripheral
>> +
>> +        Please refer to the device documentation for the channel map.
>> +
>> +      cell 4: ASEL value for the channel
>> +
>> +  interrupts:
>> +    minItems: 1
>> +    maxItems: 144
>> +    description:
>> +      Interrupts for DMA channels.
> And interrupts are flexible because?

I understand the issues now:

1. address-cells: remove this property - it should be a fixed hardware

   constant, not a binding property.

2. interrupts: replace minItems/maxItems ranges with a fixed count specific

   to ti,am62l-dmss-bcdma hardware.

The binding should encode hardware facts as fixed properties, not
flexible ranges.

I'll address both in v7. Please let me know if I still misunderstood
something.


Best regards

>
> Best regards,
> Krzysztof
>

