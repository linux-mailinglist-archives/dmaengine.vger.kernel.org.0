Return-Path: <dmaengine+bounces-1493-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1DF88BB5B
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 08:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 469BDB22015
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 07:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883901311B9;
	Tue, 26 Mar 2024 07:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TQ3WKvvN"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2085.outbound.protection.outlook.com [40.92.41.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD44130AE4;
	Tue, 26 Mar 2024 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711438558; cv=fail; b=lfPdRn83dh1d8K1WFHBQeFDhGQ2TEtn6x48lmeZ5U8Vsv/rTfJVXMx0iL+S6Qajq9tgPj/9ijnCtaFUxnBBdsjwVi6wuD4xNanETkYH1xR2JLE9Tsmqcwn7M8O3Bo4Y5xRS1VMoL8cvT2v582p6b3jeZud0upTmYLIDZkrkLz4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711438558; c=relaxed/simple;
	bh=7PAfoszZQB5tkgCANFn0VxD8fEnRQy1VsIXrgMdq900=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vE60xgcHa86ZsKDlohs0ISb+qGjhwr8t9srCNbQ0OPf8VkFEF6Khu35ENWeympJtE3F9DbC09yOqZ9R74UVAH7K8IZ+4nCsMfdvGniQ9Q1r+4loLmqjEGYS8BTwHCktNCxOJ1a5rKSPG+AJ7TmV969x7fOEF5ZcEAhwP6xV9KkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TQ3WKvvN; arc=fail smtp.client-ip=40.92.41.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHHav/NKl4hII856H6SsmK+TSSdhKKnivVxqnjjo1lNACKavE4e1nQOBfThzY9p4TNStgUa54bUrRS1UXn2DeUJ5vZ94G8U2o93DT9LUbiJ4qqqXU00R/a/4aUsBT0o8yZ3Ou0d8f5KShfiQ2b1k9Nobk1t5Og3HAF2Sfs6gSNOSSxFIaTbydgk4LrSzeC7OR5ueZV2gejokua9R0yS7PstkrR1rLzrViR/dszhdXa9lBLFnkXpoCqv1bwfs4P+lOm63u+HVP3tX84DXN3wWyBvfxkg+ngm6FGMeZci/2kmxZOenL6s0Wn8PqD18BA4N4ZwVr+vpXo2aDHSEM23MpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFl/fZAipBL8Q+DylA4mzf06C6s9syDBt7wdmgTfe5M=;
 b=Xl2dXCmV9/lAbpHehIz4YQVkLfoZe9lRP9ilTxZr8KclGt1O6stKbPnkOu063tvNDI7OO8W1SYwWJUNVg6T0S5bDwIcpbPljH7cV/p1MEEgKEhhGJfnWDWJTq2tp9/l0apM789VvRCNOXZX5k4bsx93zZ5a3uXPnwHbCIz2sOSz/ANBKvE8T4rH9AoL4Jbcj78if6QOjTvHJcD9NzWsj81rT8UcSDkTtmWUtH9CIzuCykxN8p7oHXKldAb2iHL69ZdB7tegEVd1j0IOVVFpVxUHCCRsvRLx7h9BtTF057z6s+9LiLCfpvydvb3xSKHr8k8CRyM/TzI6OQejW8OD5mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFl/fZAipBL8Q+DylA4mzf06C6s9syDBt7wdmgTfe5M=;
 b=TQ3WKvvNXKhzKngcy+w8/uKzvStZuU/uTB8tW/OMmdwKs2NNET4cLgxCXGFo1fibMxWiswecbBOJWOPEllrNiEIvKLObNFOaHDh4uMZnaSxEYYhkveigzLz9P2ezFnBgOVAlPTAsaoZIskuDz7RfJLxkIIQ6A4fVe2AFQIiUxe4sAp4qlYmXsyCLmh5Ca3/BFlgFucqt4KM//fvZ4Alu2DTJxLF/w2b5WqVEHvViyvjTsGsTB5d4E9URHCUA/2ejVXVJj8ufYB3F3hYlDTyGEqSwBo1ouwHrLeuRGx7gaRDQlVR6ScYqGFfnzw9e7mDhxxz6PugImjfhMOijg4UdXQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH0PR20MB6017.namprd20.prod.outlook.com (2603:10b6:510:297::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 07:35:54 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.026; Tue, 26 Mar 2024
 07:35:53 +0000
Date: Tue, 26 Mar 2024 15:35:57 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>, 
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 1/3] dt-bindings: dmaengine: Add dmamux for
 CV18XX/SG200X series SoC
Message-ID:
 <IA1PR20MB4953EDEEFC3128741F8E152EBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953B500D7451964EE37DA4CBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953E2937788D9D92C91ABBBBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <57398ee0-212c-4c82-bfed-bf38f4faa111@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57398ee0-212c-4c82-bfed-bf38f4faa111@linaro.org>
X-TMN: [BXe7e/+WA45fJRmV9xmhleCoeYz2PUyhkVeTTez+OfA=]
X-ClientProxiedBy: SG2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:3:18::35) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <agufyn4xsv5x4ss2hjmy4jsc4xly7mgwd6w54caovzt7nei6yb@el4nq2n3gahv>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH0PR20MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 9494896f-4646-4ffb-832a-08dc4d675e23
X-MS-Exchange-SLBlob-MailProps:
	7J/vb0KDx3ghsXKwRy/t5h7NdWkXmzB01n4ERQjVCrlygpSKn5fyca8FZGo+mvyvLouILUNhIYv26RgHDhdhvnFFPfSP2AzhGutkOb4sfgxG6QCoJZ7YU9SVjpwQG5dAjAoAypZIjeChQaIPFm9X32Rb8gg2ALTuUYKRAhhyyY4mIFlj67ssy2J6o+H+5Qx6AOzM5adGv08pbFtrp956kd2G0tpT27X09S18lYsXOi0JjtIyqSvw1eX1mhG6B2NJUAz14WYXhzLM9/ULAXrAOK8d04kG6W8RL3L78E3ARYGat4S60MlrOYt9Vhk+f/mUDnOR1WYcu6p0fEN4Yfw7UBVVk8ZiLiAmKojGI1BAtwvVyz5Z1Uo5JpaJXLERWEp67odswPSMlMY/mrIb6bDYhNOV/5rnlhC0IJmHjKKXwN3UlvSeN25PRarA0+KRRRzzDgTfdyCAnPCIT7nOiqSFj/WHzLWyYit0Z6k7RUfDx7ox100vlWUM0U7iqEKnseY2mByLnY697RCcgz+0v6OmWXB5/cYrLIoi4dTyjPxvAtjtIGpPKhJf237nxGKooiLZfgAm3+bHz5C2b+ux/dZF5vuDrDd/HlMydmu4RE4n1A2ZaFuBuThkX0kZdWACXShENwpaKlSjIJ31ZlP3wZDoz3E7qdhe73D/447itNd9MzSBfwukqXOGJtXe7Wvxp6atQf6frsOapRzHQsuwqiuh1BioskZHCKmN/kIEL0R9GJfHcHDMwXyuTkek+3PdKTEadV7c6klxVYsPnajcywO+2bl52iEgRwBkhn2fpM2X4c0=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R+WtV+rOcRanEDoHQKdtODtj2u9CmFnUJRqduR/DOjN+mAaJk0sBcnAbTyPeOBvR5d3DMAT0zQXc0I8sYDq0n8fm9doV/f/tu06ZRnAmnuWl0B8wV2DFXX7tRjL/ngc4ICYNGo6GkIn8kVjtUvNZCJCLvZNO3nwRPCBHE/Ff34Juf22hTJUybJn9rcybJLcIkZ2jJE91nK0Z8QQ93eIHIswWFf7PAYYh7Mi2Zw99x6NDBDSLeAX5t0WlgaDCu3BNdct3ym/OVMcs5eZhdBICvrxrlQWQw+jxNRT9BF1HFzhkpUAgnaJF4tSUAICBDZe5mzcuOUNi+Z0HzMjCWZKASxZWvQdXyp8/9ibB6u0/1AStQzpBshTi38Bm3LYSQd8ATgvcvK3XzITp3bLcA5LB445e6LKnoiNBL37zb+AfEdsYY0hu8vAF5remuAfLL1WRjzv422245IhwyyMdQ8iD5cPU2iBnRmUl3cixZYmjj7FK9FwQkxEojkpEjDxZ8pJY7LCdPgVyCIlQkEtWQo8kccHeIlGCqYglTpIRSICQhJZYU30uYtyqV4X2JZ59//r4oXinbeath8jkluEtKiTc0+4WkM6vWvpqB3eGaPMPDH+2eTCV9zHvlYXD9qMzw9Fe
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?quQ21RhtkKtlDLz1B+JtFfDW1edStQCN4DrBa98ABAOOgrb6LTZeuQ+8PvhY?=
 =?us-ascii?Q?8B8EuqHIa6ozFC4Hd6ixyaD3FpbzIORFMJCqs5IYhb7oyDwyWyxeYwpCs+Aj?=
 =?us-ascii?Q?OxrPdviPxT6hGIKclFmOqNNu8qeqa564kMfjW1aUK9V0wVfdyuzbTWz/qZKe?=
 =?us-ascii?Q?J2iK6Y0kibssCPzAFHH4RdJ6vGSh1FYftKRjN0wEpH8U0K7nMD3zkAHdoN6S?=
 =?us-ascii?Q?WSHSRF3CYi+pF3ruxZzPaPsz9HvhVtRUYVd5Rf+67j78iYSIfkgw57Ud52XM?=
 =?us-ascii?Q?o1ofFYAx5VQKWCHCB1vpT88heg2yiZ0jLvVQLTSMZHQGl45yhAm27We5iJ0q?=
 =?us-ascii?Q?v6ghzwK2PzA1nhgEZCaCTKwSnoJnTLmc5LgmyoUrl1vqeDvvWzDIt/FuwSHr?=
 =?us-ascii?Q?yobfmoEUUIfe5FiigCHfk6ygQo4CvZuSRQLgAllBhkqfvJuyydK48CgiLLv1?=
 =?us-ascii?Q?Re2kiPEggvOzsabS7iDMhDiv3f0OZyyUuGmDwe03Jawylj+JeOu+3UyzzpOk?=
 =?us-ascii?Q?YFUfxi3TAFyf+vDjtBfZoocilxs6ZhFbGkUJ6Gj93kj7MblPXUEAWFQDsnk3?=
 =?us-ascii?Q?o8FuzyChKTzkuSI7IVzICkaUqPT+CVlHuA5O6Vr1oyDW5z2wxGA1TfzXV833?=
 =?us-ascii?Q?Z2wHeN7q0jgiZyv8bb66y/0jdir9AYd6apLrd5xB5Sr7g+HV1snBiLnXIJy8?=
 =?us-ascii?Q?pHDDBRm4B/8WMHjoPiRE1xTD0t+wnDGIHaXW23AVHWtgDXbNcYFaJz2xLB3i?=
 =?us-ascii?Q?4x79wQOHV38PeWn53eKk+sZ5bG/b3H7RhvPLurxi6CEgR0yRq5L0wrfHOCIU?=
 =?us-ascii?Q?Wwc4g1cMCm8futXKDtFKilNCbb04rMvVTugrQXot/zUprzq8XNE07nPNS+ot?=
 =?us-ascii?Q?eYFJfHua5r6qalQrkIXJraPeyOlfmaZ9sC0BLXVaE/1TKPK6J+bL1HkJbcMW?=
 =?us-ascii?Q?eSUkQKt2nEKltsTjZ/ZRKGIXYympv0ehggZ2bnldQy+2zc/IH6hgNfdIG9ZA?=
 =?us-ascii?Q?B1/UZx6KZ1LQ5CpSVJh1pAPHDv6CalQYUXClC84hV/ThJXEWNhLHmjp0Oorl?=
 =?us-ascii?Q?PFLKpmn+uKBrmadgcYMRhYmqlHIo3LoPzGvQmeR9jf+VQkdcRZ6xym/Ju3bi?=
 =?us-ascii?Q?IajR6Gu6Lb8Ky5weicLFAfS7K8tdDTovpJh5tpl7dKvkhBIbMW7MP8FKxfDo?=
 =?us-ascii?Q?N3ON4OaQ++wAOJhUOPM6/ODA0lbZjKFePW8XnrX7qWXZqf0a5DA0frsSMBmY?=
 =?us-ascii?Q?w1V/uthsww/5FH6LWANG?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9494896f-4646-4ffb-832a-08dc4d675e23
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 07:35:53.8108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB6017

On Tue, Mar 26, 2024 at 07:57:44AM +0100, Krzysztof Kozlowski wrote:
> On 26/03/2024 02:47, Inochi Amaoto wrote:
> > The DMA IP of Sophgo CV18XX/SG200X is based on a DW AXI CORE, with
> > an additional channel remap register located in the top system control
> > area. The DMA channel is exclusive to each core.
> > 
> > Add the dmamux binding for CV18XX/SG200X series SoC
> > 
> 
> 
> > +
> > +allOf:
> > +  - $ref: dma-router.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: sophgo,cv1800-dmamux
> > +
> > +  reg:
> > +    items:
> > +      - description: DMA channal remapping register
> > +      - description: DMA channel interrupt mapping register
> > +
> > +  '#dma-cells':
> > +    const: 2
> > +    description:
> > +      The first cells is device id. The second one is the cpu id.
> > +
> > +  dma-masters:
> > +    maxItems: 1
> > +
> > +  dma-requests:
> > +    const: 8
> 
> If this is const, why do you need it in the DTS in the first place?
> compatible defines it.
> 

Yes, you are right. I will remove this property.

> > +
> > +required:
> > +  - '#dma-cells'
> > +  - dma-masters
> > +
> 
> 
> I don't understand what happened here. Previously you had a child and I
> proposed to properly describe it with $ref.
> 
> Now, all children are gone. Binding is supposed to be complete. Based on
> your cover letter, this is not complete, but why? What is missing and
> why it cannot be added?
> 

The binding of syscon is removed due to a usb phy subdevices, which needs 
sometime to figure out the actual property. This is why the syscon binding 
is removed.

I think it is better to use the origianl syscon series to evolve after
the usb phy binding is submitted. The subdevices of syscon may need
much reverse engineering to know its parameters. So at least for now,
the syscon binding is hard to be complete.

> 
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    dma-router {
> > +      compatible = "sophgo,cv1800-dmamux";
> > +      #dma-cells = <2>;
> > +      dma-masters = <&dmac>;
> > +      dma-requests = <8>;
> > +    };
> > diff --git a/include/dt-bindings/dma/cv1800-dma.h b/include/dt-bindings/dma/cv1800-dma.h
> > new file mode 100644
> > index 000000000000..3ce9dac25259
> > --- /dev/null
> > +++ b/include/dt-bindings/dma/cv1800-dma.h
> 
> Filename should match bindings filename.
> 

Thanks.

> 
> Anyway, the problem is that it is a dead header. I don't see it being
> used, so it is not a binding.
> 

This header is not used because the dmamux node is not defined at now.
And considering the limitation of this dmamux, maybe only devices that 
require dma as a must can have the dma assigned. 
Due to the fact, I think it may be a long time to wait for this header
to be used as the binding header.

> 
> 
> Best regards,
> Krzysztof
> 

