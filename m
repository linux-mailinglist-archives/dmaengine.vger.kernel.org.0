Return-Path: <dmaengine+bounces-1080-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4D1860877
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 02:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90CDD1F22F93
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 01:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85785B641;
	Fri, 23 Feb 2024 01:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KpTHXJhU"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2108.outbound.protection.outlook.com [40.92.41.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F6A3209;
	Fri, 23 Feb 2024 01:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708652821; cv=fail; b=uJfpfvJX/FyWAj1tddxkjwDHJL15TwTjE+fBalA2pdmfSxzqYcaQGaJPMUV5DmGxL3zYjFeEZVFbEfuUpyTdSpb23n7MXx9plj0RWvMQwHWLWygU5caU+n4VirkPIsMEHV3f4VsljrhBL1i6A9CllczNDB0gcvvTuMwy9pJC8UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708652821; c=relaxed/simple;
	bh=BvdzCsiOuEQnLzHKvLK10SgDkqW466AoFOTJ+jvZST8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KgMH0ENyEToY3IXaS7O/IYVYRpfsdD9clH3Zoor7gigpMFcUjjvvTXq8YrE6uAKGF/BTdbFWy8PcoBUFqPseqri0sjXNwkTdf9I/e36hSI6M9sfUaYLDqvzwZ824BhRQ010t4H5U4RW6IOpbMYfiTOR8Amqktz/6sNeDp5GyDVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KpTHXJhU; arc=fail smtp.client-ip=40.92.41.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CN5DOV451z0/uW1RstPpGYOpy30CR8xkZCxFlb7GHGHO1bawTZqLhGPRO0xDnjHdjXsel36qK1InWST9rvg8mx4Udj43SwFTd3Wg8XuX2bDuEZDBQoS+FOEJGIQgYN83SHziDpiR8OIprdJF0hyuOo3q23VH/lrhiBlaxk5Bp2wjhNpXzM1PztcLTFAQ0mqfKUftEvLqcZIi9tRvy/mb0oy5EJ+IrTZxUUOrVgacpHLngQfp64FGOHL3uM4vS2Vb5n4KOkiMurBSBwsxyHQqqd/yIJN3x+HrABi0+Uyn4E1TqMfLlCo3pgX6pDtzZxyzuI6eo7blMGuZndz56PsODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8flhnJjnP/pjoa2t/0+6XcItrSmDHmkTuieKtLHOs4=;
 b=F2h+1Of7dfRNhueIPyPECurk4cUkX+wmWo7S6q3ii13BlLCvWrfxYJ/ba2vURkoNW4yMepFUSJgbvm8SAFhl0rCg8lAxFM+V792lfyeSawqcRBpHOdOXMrD7R+ZiYFc7kHGpjwJ0a9VcLVFZajWl+AMSoyOnHobLXSnBgNt/ysA0+Hi4PAlaeM3CDNQFNHupcxcQa3mku9x/NRf/3bc0F/tltbMgq94185irXSZzHvmFmwyTpo3nadkC8+UVQegJH0PR8Gm0U5bpf0rrStNjR4ethoBeUMEDPeKXGDhJADms+E4Xq3KSj1bxueryVfprFVeyfQejOoTO3wriajvslw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8flhnJjnP/pjoa2t/0+6XcItrSmDHmkTuieKtLHOs4=;
 b=KpTHXJhUpEwwAzOqzQ/8dKnHIaMXP5aYKG17EHVoGlLu/JAzx3Hp6GzVyK31Ou0a80mKNqGK6cYMdnpQur8rg//w6uBEAmOqSDZP29gmil0CuRdI6UtCScP3e4QCcPrvZmbUCGBsF9PuzJ46HcXoX7faUgcW4fT22LcWlpfXiDeqnRKTl/fq7sihVf4iiIiOtUvUYP4JOB5SjMyWqmp1SW9C6viH7xLB0dXRs0qe5ileRovC12F7fp7e5kJ/wjTP6MrP1eXP1Eul10Qinb0kDHBAd2597TOKY0y4qjBxClClkGs4TDD/M5QmmqUWfaINi13oa+dedtldgupsyhV9MQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB4457.namprd20.prod.outlook.com (2603:10b6:510:13d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Fri, 23 Feb
 2024 01:46:56 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7316.018; Fri, 23 Feb 2024
 01:46:56 +0000
Date: Fri, 23 Feb 2024 09:47:05 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh@kernel.org>, Inochi Amaoto <inochiama@outlook.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Liu Gui <kenneth.liu@sophgo.com>, Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: soc: sophgo: Add top misc controller
 of CV18XX/SG200X series SoC
Message-ID:
 <IA1PR20MB4953C60F0B70D82922D3AD36BB552@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <PH7PR20MB49624AFE44E26F26490DC827BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
 <PH7PR20MB4962BEA2751F7C45A16E40B9BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
 <20240223003334.GA3981337-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223003334.GA3981337-robh@kernel.org>
X-TMN: [3Q7LaCtfwTJTrWh+CTkufnqkNi32nr742q+wNWTGq5E=]
X-ClientProxiedBy: TYCPR01CA0034.jpnprd01.prod.outlook.com
 (2603:1096:405:1::22) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <upbgq2yq3jddnvvswwojx3fcd6zd3kxtpbrwzxnnqy64aw2etp@proeihjizzhd>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: d16c7d08-708b-4516-2769-08dc34115142
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k+Klvno7K7Aa4+tdHKprMWHrc8YQdFHmvPfBlxRgyQACnSB1ZOIU9hmsloO/ljOMGmCeJA8VFR7K7BuiXwR1OMPp/jfAS+M61HP9J7+krAeHvTfMn5xxNgUg1QmjUNm7E61D6PDqMcFKE6elPSN4T91UOChraVnRONVDjbKvN4uajoIcPW4FTc38eJEQbp8v+8Mi/k26/Jzw6JK0XP7moWSBd108N/DDI26zS4ovBOLWKlejR0r9bXeiA9lkzlKGqQdNL17prYY3l2jqi1tPKDZMY0y5zRnbS4MsIbpsMz6fwnGct3QseUBm4oxcPhkCLacm6F22pepiRfavYM4QEMc68tEfyk4W5e3LRtWa30Gdq6KR87MqO5ekKvUkEmXLNdjFDyzyyY+oTaQmxHPPwAgdASbBqQdpud0eGZoQh/tNBg4oEVULlaygT3Qx5ZuYmBGjrvokMKGaXXE18YJVEpXktjqkpCBXmr/9p6SazRtwhNfRQdwajWrjyg7blQFqBeCDsE4ZApevvx4emXvmOsvmlET7UpG+5Ia1g73bqebW7PTgDVqvJDKmHvaaiz0hVzZGc3yW89THqWY4dexY0yozpyoX4s4U60G9PAUnP4LVVjPhjYqUta/+fCFueIPrlJVTAoWnEHyZsn18xefs+R8NW3HcgCOiZ2++d4kxy8U=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fK2V970UpS/Ij1nF1Nf/gMC78Lf3Qw9Qfxz9rN/ybVRiXIWJk3R7ru7EvwBu?=
 =?us-ascii?Q?pAeDBnAeXqtV+cSBxw2hjPHu7DFlzBbqmnkzlN3g7bDOGToEFrDgPmN8EYp7?=
 =?us-ascii?Q?dHQik7qBMNHVtOIY5yGTn/RiTj1Nwy14BJgTpD8MLdKzGyOWTsRYeZmpMhbX?=
 =?us-ascii?Q?lQ95R1OzV9+9acgufLfywrthYF8VdtREN9s9KYUJUFsjM+IB8+Y9H2t2Qhbz?=
 =?us-ascii?Q?N55z/5+Yjx1ZQRSPq3AQbLidi/Dxkm+oBt4R/WYvoghikIH/rOISKv7Wbged?=
 =?us-ascii?Q?91bxv+Xp51oUOsIIclkl1HsASr2QoLYUmgDi3b7yy7lquAheds+GcFSjFEJN?=
 =?us-ascii?Q?THlV+Z6lxcpIaNPIuJHFlSXkYcqZJzVEkLh70MBBMUQGjPCL81DaL6iCSJW3?=
 =?us-ascii?Q?bjN/G3afGfff/atT/tc66mA9z882V2h7C1ndUBtWhnqTV7DoMzEHnUx1p6rC?=
 =?us-ascii?Q?KuFV8J9GRRlrMX0uaklfWlsGLXo+/YnE6iE72XolOF/nJohUV0lVY9glBS60?=
 =?us-ascii?Q?L37ZrimPBvzJO7LR9RbPPq832MIrgJszZ+wam7ms5e0EfwFEq+PjJnKDN3ir?=
 =?us-ascii?Q?NZCH8l6t5LBUYKxY4KHG70B2eGsyJvoMyBrkjRHGLSUfERBN+YXjuDa4MSbj?=
 =?us-ascii?Q?Avr/S2o4An8Tzb9d0c8+6CTcPnEeeb7NLoSWXtpYbkN3NTKyx5vIjd+R8N3s?=
 =?us-ascii?Q?4HSsqQ5a5QAjGx1FXuy76X8sD7YwKb1HEh61CqN1P0O7A1PI52YmqLpwaJMZ?=
 =?us-ascii?Q?9Kdt9FFZP7CiVa4kBb2iTq5C54ZkXbsXl9x0cDRbtllCb5ZaF6iroTqwITnh?=
 =?us-ascii?Q?00swOCcUjOCSwahRWrNjD/WpZ24joBWWOQGM+qbH3vns8bxizMdlAeQWokb1?=
 =?us-ascii?Q?4E5Av2Kg5RnnXAWuIF6dUDCpUftOU9gNf+RyQ46h+vFs4KimihoRC8+xwTzb?=
 =?us-ascii?Q?Ca33vRfUpx/yJo+jQs2QzPVdu8haqsEx4cVlCqAlsY8cWY9BKxRFhhUFEPGV?=
 =?us-ascii?Q?E3jmNnoBURF3tZqF1N2GIL7cuN6LjO5G8247QWF5oDtNmQ/zv/LvUIqWiNpA?=
 =?us-ascii?Q?Kfd5+S+lC98/bQExQOBeZorRge3inveX9mJYsow0WD8Y2Sx78hV4rUrRJBGe?=
 =?us-ascii?Q?gXTwoCjOxyCwMSXrTpXILmF4dhtdNcofhMtorjKeaU/iEHbv9lSmPcSDp/If?=
 =?us-ascii?Q?qsKjUPJBKLtHUZw5c4vD3LQtMh2vX/dOjIFJW0DFJ8RDJiOo5jxpz0ABtl5F?=
 =?us-ascii?Q?jajfOqP3PFfX6veQkfHf?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16c7d08-708b-4516-2769-08dc34115142
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 01:46:56.4298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB4457

On Thu, Feb 22, 2024 at 05:33:34PM -0700, Rob Herring wrote:
> On Tue, Feb 20, 2024 at 06:28:59PM +0800, Inochi Amaoto wrote:
> > CV18XX/SG200X series SoCs have a special top misc system controller,
> > which provides register access for several devices. In addition to
> > register access, this system controller also contains some subdevices
> > (such as dmamux).
> > 
> > Add bindings for top misc controller of CV18XX/SG200X series SoC.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > ---
> >  .../soc/sophgo/sophgo,cv1800-top-syscon.yaml  | 48 +++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
> > new file mode 100644
> > index 000000000000..29825fee66d5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
> > @@ -0,0 +1,48 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soc/sophgo/sophgo,cv1800-top-syscon.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sophgo CV1800/SG2000 SoC top system controller
> > +
> > +maintainers:
> > +  - Inochi Amaoto <inochiama@outlook.com>
> > +
> > +description:
> > +  The Sophgo CV1800/SG2000 SoC top misc system controller provides
> > +  register access to configure related modules.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: sophgo,cv1800-top-syscon
> > +      - const: syscon
> > +      - const: simple-mfd
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties:
> > +  type: object
> > +
> > +examples:
> > +  - |
> > +    syscon@3000000 {
> > +      compatible = "sophgo,cv1800-top-syscon",
> > +                   "syscon", "simple-mfd";
> > +      reg = <0x03000000 0x1000>;
> > +
> > +      dma-router {
> 
> Is there no defined register set you can put in 'reg' here?
> 

It has multiple registers in the syscon. But in fact, the dmamux
is a virtual device. And the syscon device only have some discrete 
registers. This is why I did not put reg. It should access the
device using the offset defined in the patch 3.

> > +        compatible = "sophgo,cv1800-dmamux";
> > +        #dma-cells = <3>;
> > +        dma-masters = <&dmac>;
> > +        dma-requests = <8>;
> > +      };
> > +    };
> > +
> > +...
> > --
> > 2.43.2
> > 

