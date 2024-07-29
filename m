Return-Path: <dmaengine+bounces-2754-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B45193EDC0
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2024 09:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9451F22185
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2024 07:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1E16EB4C;
	Mon, 29 Jul 2024 07:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NkDXW+29"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2031.outbound.protection.outlook.com [40.92.21.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46542119;
	Mon, 29 Jul 2024 07:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236440; cv=fail; b=nzjBr+XRRsf3eYam1Njs6jkZp5C5AMzou6UdXsJkExQpToJwmQ5aUS0i+la6sb5P6qE28qRKJ/exaXPjKmrdPUaCeaanSn8nFSZ2lwd9WCTa6k6ZPo5Dt8UMX3EdCa/QZ+0iCvE8aKM5CSeRCJaCkyNH4DVWErMkI20TbVAfqa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236440; c=relaxed/simple;
	bh=8WBMYnNO+fo9kNLP5pzJz4+fHcmxIijdbAllD2+6bH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aAMaQIXZUpSLX7+lPudrMcduv4oXwpLpC8JTC6TEafcFmCMeq2GuytX3f2mQiNb/YvdU7mCsOWNhXjaG/HBt4FexU78OIzB7cMjl0gx8nzEnLVP03i2E5XRrSom1xSuZ/ISjhdlIdwpJUbKYXdHZdB5kGgM7SYYJNBpomNQyKV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NkDXW+29; arc=fail smtp.client-ip=40.92.21.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQX6AsudfsOHT4yh4SVyjnpr29TlTO0giQgdFRFw/OU73QEnKMhW98h5+OciByNVfdCPqr3lfBdjf/cslEBEMYdR+YuIqROUgS1fm8EYtCC/R5RVlPaFk/vjnmkkJ2YBiTFipPwjoNzvo6ZZBRWArLpbTMDiYpSSsW8h5EFxP5DBJ+kDWYxbcYPg5P4wCZJWsVRLUJ7JX+Bbu7alHE6MgAo4jKSCEZqyKla5EyEcMJAoCqu+FiHq5LQIgTsIuv2Bwph5WHioQ2cFFzcxGg1cdWBmyiWHNBFXKL6VaY1fD01vVNm2xYNjPD277ow6yKZx167MLUlB30QCWDOR+RLR5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fN+1yCZ+QNH+gRv4l7bg8Tn2fvkOGB55tsFCOU9vuX4=;
 b=IV7I3202g+vm35xJ4sy95ZV9+cq4bCg/QpvqVqgAe8tKRb291t7HUnUFckRTp0D5KfA0tklI6TYszEWrg/k5Bomy0RAlOLEwynh/1hU8Th0fXuJbb2w0F7dHBjyZZ10NqpO/BuyRqUEEJrv4p1Vg4vzqf54Hb5IEMbEJtw/BNoeOrnjk1GlS97UIw0JidyNWg6RzeKyF0m74VSpDzwbw1ZzxVwsZ9v3ppUW+ZL/vrzg9wHIuP9E/aqj5ZyPujaW+2Ck864CNH/smJ/3MAb+gbA5HgdiiyYbJpI/BGGZ1ZVVRk8+1jpjfME8081VCeYp4ueL4Zy/F2coVYwqjiJPzRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fN+1yCZ+QNH+gRv4l7bg8Tn2fvkOGB55tsFCOU9vuX4=;
 b=NkDXW+293Nepf/E/KGLY+UVn0pfhQaqjVZxo0p3E945zIeDX9YUz65CFYwARC7p39tUiJeyF9noS2I9bEPZDUk1s2JfwtQWImSDpUmkIvPO8AzYbgDJ58i30S86X8HW7e/DzBOgBKGh4nVGbTkYNUmOtAx9IM+XpJfdJrQ0km3QRYRBlOloSmSKzfKq2FNqXcMIEVtzw3jMAd8Apvy064F5q8jbLD5HDYzRPXe5zJJEYCPucQeFqiuO+YsmaalSdRqPUF5qDLw+wzTmR34mwxndrVr14jYOQ3dLBgMnvoeT0tgsr+nQxstpPstqzNF9xv8ILbwVzXwGE4DClLMm4tQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB6122.namprd20.prod.outlook.com (2603:10b6:806:33c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 07:00:34 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 07:00:34 +0000
Date: Mon, 29 Jul 2024 15:00:08 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: "Rob Herring (Arm)" <robh@kernel.org>, 
	Inochi Amaoto <inochiama@outlook.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, dmaengine@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Liu Gui <kenneth.liu@sophgo.com>, linux-riscv@lists.infradead.org, 
	Chen Wang <unicorn_wang@outlook.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v8 RESEND 1/3] dt-bindings: dmaengine: Add dma
 multiplexer for CV18XX/SG200X series SoC
Message-ID:
 <IA1PR20MB4953E3AEACAC85765AE9442BBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49535EC188F8EE3F8FD0B68DBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953865775FA926B2BA4580CBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
 <172223050278.2763977.11180028101195359000.robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172223050278.2763977.11180028101195359000.robh@kernel.org>
X-TMN: [m2Fi3HpymJN3mW/ZibNT64M3kqP4n+K46CfWUfFwl9s=]
X-ClientProxiedBy: OSBPR01CA0102.jpnprd01.prod.outlook.com
 (2603:1096:604:71::18) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <i7vwif2wxsntz4bas5tef34atyucqu4fajbqksylndi7ydyomc@satsfrptm6rm>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: eac6e5e1-646d-4e2d-0b36-08dcaf9c24cc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599006|19110799003|8060799006|461199028|1602099012|440099028|4302099013|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	leVOA0GwIgR50yxD+zNw2nG5JPbVzfs50onfEVGcnmCCDWph+SwB3Y+mkUt86dbsJWF3WTG0qbphF7m2VZdS7ZoYQDUPRetpvFAPf/FxsuWgry9FUL/rNRy73IQ2OVNM/3CCctcrpa3xsZhLF+a+Zbwsw9ZH70HGyTC4Wup9y8DcVjrdu9Ivd5zp3ntmO2P8nELYWbqR7dhosP4knEXsGfiWSAynJD2wkKJ4IAbfb4lsyZYjwaDJV85rrvOnoG87+dqeYepxqEEnuydKQtkTVr6/wfe+hCqnATLUxDn8i9Pj/N3WryJ08r7xR2p3GBPWABbwOxTxKRjhbNtf+XAJd+LFmx0Xgwy0yQ8jZNJPmsCzU2ifnDjFcHiFUsGe/TVGt95kNNU5RxeDH8OHYCmZT/iyfDX5U6Kb6nTkoSlJDJnabtJQeKRIp3oT78WT/fG2gfN9AIg2IN0ca6i9tZn49zlVDfjy0T+ePtaIiuDa3QLh8nVqX+hUC7UiwseKmo3R7CaPHLlrRgRIGK4jDkAFG3+/H1eXLhSVKWWoQnbZ0EHG2du8ku0cXRUfQsYVrQedeqwi/ge7Si8Jf0z76Ui2/EeNHnGWdOFhIcl3YqHnD77ObOPhETXW82PAYzHJ9nbh6kduclZCKiMk//qPotdBsOspXGa/eXxqOZlzL4x+bJ+xcgCXLa2oLpd8m6MMtwI2GQKN/qFndISLvEbrU8CjCN4aDMd9Dos8TmbQJkparZEpas7aBKzwLI7WqSMTgdgIvpXr80KQIWapKInC7kPzsoqBEJKsaEJHOy7U02tmwfH0+q6iXtELxgByKgknRpM1
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e1EGD4uhoLGImgy/jVMYT69Gu08B+rCrbDI+JP75xN3tBs8gMn5slOWqCKjF?=
 =?us-ascii?Q?t119nMmaj0ILmZTz4XTi+Hd4O+FLG0Z7vepXLFD2XKMbmLEaWGXiZ7SV3nQ8?=
 =?us-ascii?Q?xQSmScH9fz5dvstBAipn0llteRsDYhn16agS+sgawdjSmekgdWDrtmif1iE3?=
 =?us-ascii?Q?J65+ZGem5G+Uuwj4SWMeRw6DMiImCjDIHkSngh0MQ1K241on2py0h451b6LN?=
 =?us-ascii?Q?l127P1tN1ILwCeQDsZcKMXMXqlyGuP5uRnd4S6NM+n0xKE1zpkMKeI7OPrg1?=
 =?us-ascii?Q?9U2rGALcylonNhicNvL/UlN+5jlrsn/ERAh6bv1QHDaTy2S70Mh6QvZ3ncSG?=
 =?us-ascii?Q?EFFMRI4AlvNWiEPfQXUiiL2v2M/4753Rkrixv+wrZsBNNhP8o69C0aHLEb62?=
 =?us-ascii?Q?0UOr8mlv70RgJ1SVwKFMn/1BFu3ihgppSrPtKZmzao6MROyZM4djb/Fbl6PV?=
 =?us-ascii?Q?vnKugKVstLpQKKzIwsjPlYKhxTat57R/zMSPlfRmqItgWcWq6/czPRYjPL87?=
 =?us-ascii?Q?6Ikp3VpqFImTqKyFYUWajQnuCv6c9rezhXJ3HFb7CtGYWVI6aR2WC773kITe?=
 =?us-ascii?Q?kPgbJnb6Sn+aGgnQJEgvyuOH5qAhvNfXK5itdboZ3tesCyu/KZTtWvIAN8iQ?=
 =?us-ascii?Q?/oMBWamIBBT3dNdO81d01hAUyE5GWYhKpEtrDELbTKD69Ou5RGCKOz0syItX?=
 =?us-ascii?Q?4BS0fv7tVbka4Pny6W1qIQVsSQSyICEgKlM2jUTfBxwus5F5XWTHTfdIUXyI?=
 =?us-ascii?Q?dKEzQWrXcX2B9LDCqCBUay04jEkucmS95Xm4Akszi0Od/tmzidydaMFQ0Dns?=
 =?us-ascii?Q?UFuDRfC059Pxb4AbN60h5W4vhZEuHITxtQBc4wsGLt/Z+KlWJO4LyurZIegt?=
 =?us-ascii?Q?PgCTCzd53xLG1eZYErfaUR0Qa9A3/AdMf2tVy9h9jcAsFNLyA2qkfnvyDFQv?=
 =?us-ascii?Q?nfeZjqcs9vOubWCOUSfzr4WYgBUEWlHGpKRINiw51+/gUAc0ZEnL48A5C/mz?=
 =?us-ascii?Q?U663KUvn7pjejdQWNYLXOd8mNEE++nWYqNErjI3KLO2IknYxjGqyWKVaXBJO?=
 =?us-ascii?Q?02WxSR4RvKrwqJmIs8W5SvsbFNVPWDwYSSvWEjMVphMuX7/I9XL2Rm2Dl4Xk?=
 =?us-ascii?Q?Jiu1KXhbfXmC7BkFasn837Cf7SytGP56KvhY7ja58PDCTvog21GX/e2tOXli?=
 =?us-ascii?Q?PYj2UUJxd/dcuRP38Z1I/aFhAnHh4QIS8uJNuW1E1LKTlFGQrv69S5rOuCCk?=
 =?us-ascii?Q?RcDaFZQPpuACTi8vDt9U?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac6e5e1-646d-4e2d-0b36-08dcaf9c24cc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 07:00:34.9080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB6122

On Mon, Jul 29, 2024 at 12:21:42AM GMT, Rob Herring (Arm) wrote:
> 
> On Mon, 29 Jul 2024 12:36:51 +0800, Inochi Amaoto wrote:
> > The DMA IP of Sophgo CV18XX/SG200X is based on a DW AXI CORE, with
> > an additional channel remap register located in the top system control
> > area. The DMA channel is exclusive to each core.
> > 
> > In addition, the DMA multiplexer is a subdevice of system controller,
> > so this binding only contains necessary properties for the multiplexer
> > itself.
> > 
> > Add the dmamux binding for CV18XX/SG200X series SoC.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  .../bindings/dma/sophgo,cv1800-dmamux.yaml    | 51 +++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.example.dtb: dma-router@154: dma-masters: 4294967295 is not of type 'array'
> 	from schema $id: http://devicetree.org/schemas/dma/sophgo,cv1800-dmamux.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.example.dtb: dma-router@154: dma-masters: 4294967295 is not of type 'array'
> 	from schema $id: http://devicetree.org/schemas/dma/sophgo,cv1800-dmamux.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.example.dtb: dma-router@154: dma-masters: 4294967295 is not of type 'array'
> 	from schema $id: http://devicetree.org/schemas/dma/dma-router.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.example.dtb: dma-router@154: dma-masters: 4294967295 is not of type 'array'
> 	from schema $id: http://devicetree.org/schemas/dma/dma-router.yaml#
> 

Hi Rob,

Could you share some suggestions? I can not reproduce this error with
latest dtschema. I think this is more like a misreporting.

Regards,
Inochi.


