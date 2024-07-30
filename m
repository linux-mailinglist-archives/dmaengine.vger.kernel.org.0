Return-Path: <dmaengine+bounces-2761-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE0B94027D
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jul 2024 02:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14D5EB210DC
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jul 2024 00:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD6B10E3;
	Tue, 30 Jul 2024 00:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tlSac8AB"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2061.outbound.protection.outlook.com [40.92.19.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7694A1E;
	Tue, 30 Jul 2024 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722299776; cv=fail; b=HhVQ+IbOTSRRfrHv8sD7M4dGUbVAR+A3q6wEX02lZM+QMZ4Uj8jJq3kTuhjk98UIOmnCelzcEU3rVH7JkYZJIPnsjthPXUwH5v5iDy4Hfn5U6oRiF9Nm8A6bILSiMYtNb/4D7I8g0kDDQrxiPq5azIiiEutoVgE+fui8MpC0zes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722299776; c=relaxed/simple;
	bh=GakbvSk1taPK/cC3cPUxZaCj/OFPnGxZg5FmXebbS3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FWrhJ5Q6Dh/6X6OUr50YdM9koCOPzknp2kMIXOAou+FpXxtPtKMuDMhLyeo+roL1rO18hYwN5I4WrMi9RbNxWJ3vkePCGQFer3uevSVk8eilcdHse9ESlu8/ULwKMBiQr8lHGSNeJlGqu+S/AtPfBIpQUtP5F5VTQSAcF/GqGJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tlSac8AB; arc=fail smtp.client-ip=40.92.19.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGdT1PrILM1GHZVfaOB92Udeq5xO6+kJJpjhsGucJuQo97CJFP3jDKM6ZGMFIIAHx3kZJV4HKWZ9YhNsZt/eoCs3mhDWtpMbANpUMD+tYLUqpPLt73uWP7uGy8AKo0+LlffGr6HbDl1/rzdB01tGefn2u7CIcqXroMrlYa7dHzsIR2a4EkOpCcxMpFy8Zgw/jwba63tv9+FkutVr1TpaxwME5Gf2WAvX/JZ0QwCR2t23l/NKDp0FY1vvKQqY+4pyL6Z4KuNCVI8GDHzlkwgUwJc8aZ9XP9+OgY5FNpbrK9Hj5elXrTRqqT+HGqSELyAN28KBLXmWbJwBVRtCgK508Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erzdgCbknvnZsiIZASlCA2aDMyRHIqkSj34n9C6KhMk=;
 b=YfUeIY7eKZ5wUH2OmCHcvszmDs7qN0oy27FAIUg/czDmqinCaUu70C4FJ/H064xuYQBdEFEA+PcSkQ0VkCkKrwkrSYqo0IaP3oQGe6nkQjytKAi0YyJWDC5j9HnZ4VpdtSWjN4hUX7DQ+mPYoCZAjyx+1wDvnzzc3TCqUBoms8HmKAAjORz/aak9kSmI+tP6lXEYXdeM7hs7balrM3cGpFdrpIaYQvExklTvT+drSPyyTtrGCvMB6sXjGo8fpuS0q7KGcUnElnlLKxuuxTvlOcl7UNrNUx/RJoOrAybna5+K2TZJbcEBxcus8tCNsjer3xQ2LmgCHLXyOJaVG1O9qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erzdgCbknvnZsiIZASlCA2aDMyRHIqkSj34n9C6KhMk=;
 b=tlSac8ABRtlZfBFKMzAmNsSVYp+XFQzvC2+VlEr3kCscFavc2S/e/x2ESTTR2as1QBUJH32tb1khfkrk9HmrVx1Bc6xsCk742Tif0/1jbAMP7cPGKCgLV4JCWUtJrmy3ONY5q5iICFzIMpIfrEBnZOX9RndMmhGaVTrvXNXjMxSaFLaq6cI4D0KbfcLbiZxno4ysqJl3Kzo7JQftVdzYsvkDfviiKKdaoGzXjDVP9gdwfw9sqPF9/5R0I9kR4tX0I2koq6UWuY+CpZbZaQQGq5UrFbLQHGyR/3UeeuZ105Qt5d2VeTFPPwPlug2+vhLz1N7/Ki3IFPWHD9+wArv4Ag==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB5211.namprd20.prod.outlook.com (2603:10b6:510:1ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 00:36:10 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 00:36:10 +0000
Date: Tue, 30 Jul 2024 08:35:44 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh@kernel.org>, Inochi Amaoto <inochiama@outlook.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, dmaengine@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Liu Gui <kenneth.liu@sophgo.com>, linux-riscv@lists.infradead.org, 
	Chen Wang <unicorn_wang@outlook.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v8 RESEND 1/3] dt-bindings: dmaengine: Add dma
 multiplexer for CV18XX/SG200X series SoC
Message-ID:
 <IA1PR20MB49537B8C3871AE401426539CBBB02@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49535EC188F8EE3F8FD0B68DBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953865775FA926B2BA4580CBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
 <172223050278.2763977.11180028101195359000.robh@kernel.org>
 <IA1PR20MB4953E3AEACAC85765AE9442BBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
 <2e4b504c-6413-42fc-a544-472d4cc1a06b@linaro.org>
 <IA1PR20MB4953343445D88F046E1D28EFBBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240729150201.GA334758-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729150201.GA334758-robh@kernel.org>
X-TMN: [VnOr2tZ/DpwXyqkEskKXCVsh99E5rhN4JJslMWqWg5A=]
X-ClientProxiedBy: TYCP286CA0233.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::19) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <lhfayonvgwnj25cpq255mptyhdljik3tlocep25k2xo2xecf5j@eftwhf7szcyw>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bcbf21d-7e5e-4d59-a58f-08dcb02f9bc7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|5072599009|461199028|1602099012|440099028|3412199025|4302099013|1710799026;
X-Microsoft-Antispam-Message-Info:
	iJwdME2OOWoLopjSnXwIjnfmB8lc06J4wVKf/0CFcTa0nr9uWNh8awAN8pN4oJWofl6gnBc1u9qKkmqQBSadnSJme7z1SOtX3nyjupjf5HHG21o1zqeVCWCgBrBM9Tt3PsxF5D2NKiDIs8ZxEazHdKOZ2v2IlCUGDknpIHLUWRyVcy75LYQzRkcl3uy4TDDnn0iYoV7BRsXAtHvASrMQMv2sEMRJ7nx45Fv2jBDbunCH45RdlDWcjGrXs45K1ACiqVQC3xqjMfn3POzz8EmxO1OknDed14efDhV6Tb/LXXRxDY6oucUXOxgYNUUmkmlsDn+UayQkVnRP3AGOw4B/KiLEqF+W0JkLrCvD5FqbYa+2kbtnpyq1nJmKVGyayXXHvOS2d039RzD1eS46mk3yEmcIP15KzmNyP9OSJTo+xZE5VAUZcuyEEQqWVOAY295Mrr4+7E2YfgxeQAqwfR7ldMggk6TC6n9DiY0ENDHEaxvPdPkxRt6NhCRcoaHbjMj4lfiESw97Tz0E04m01uOBmjZ++YWD1kyBTy9Fn8oS0LAyi86Px8MlowRoy0vZhcTUcwwRAwMe5qI62n9zm2Dk6qcm0e33uiXNYFsFzFytWFzl/PkIYBE9rrZPvfmMalI+xnx2duU4soU4BiUxm1EtVpLE/Va4HKueinmQJaKdFbv4WnQNOH0T71zWEMHWFMqh05kBrqsmdVOoT60JrXJDxXoU33xuzu+bfasMP1cdx4N7NTzOMKLxcXxAYKUDnKyeAD1ZiTzj6suGFILBrX/8UN7gpiQsL99ktkSireVFzm4qXeyKsFgYlxOyzfDv69Ol
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8aoF8nTY6+OS5Q1y/VyYT/YjmsWbg6nCWn/qRsqdKawl5U/r4pEMl3gpV67E?=
 =?us-ascii?Q?yN6yzIesz7BhuVPNyOtCmrnHRo02dHZn/7SPm4F7UV03Pt5bIbfjGb3b7V9R?=
 =?us-ascii?Q?t7IkuBdN577aDTYfalzNUPNIiELDxnnRIfj2CZ+tGKtFsZwTnNWyruPXTF5W?=
 =?us-ascii?Q?zna26rlD50x27xs+GNuQEFEyecjIeTT+IxeQ16h96qDuxx+JOzjD7JCg8Sa3?=
 =?us-ascii?Q?CVLwF2CPmv00XW1PbH0I4YN3hTVZGv6+ryHjefbjP+XQe7xbG70XgoN5z/sm?=
 =?us-ascii?Q?42bjiCGgndBt86JgeuZBDT0+6YEiZouFPvlFFRc0clElqXnEYYdnC05oaMCM?=
 =?us-ascii?Q?Hc4Z1sb/U+wtuz+ZZxB04j/Dcjv+fcGIkD2/jHs/azenIwH8vOvkP1peT+u6?=
 =?us-ascii?Q?uPUcA+38WOA/JwLczaqwLZ+anEL4YiDxsOMxUtiz4ql0j2Tcp30MKM8S3Ay/?=
 =?us-ascii?Q?cDG2oQMcr8q2znT1/hNYH0hk04oYYajVAHccwEXTjtWtI8uQ74x4NVEAidza?=
 =?us-ascii?Q?EKtlxq0jsg6zv0aBoN+Nmq/TCbkLqf3R+cgw4AMNoVIux065gGUa2H8mgZ/+?=
 =?us-ascii?Q?hN/JzzezpGB6QwLY2RUVxUznlnk+1F6j8ctTPyRlrWcvR/+Nj8jm58oFVMfS?=
 =?us-ascii?Q?6LPpNPFbvwIu1eKD0a3QJLzqsMtsykMGJey29DtGPCgMnh0+3rY8FgWGtq1c?=
 =?us-ascii?Q?Go8LHWAx1SE+Y5+a2iW9pqSUkUT1MzucSZuhpRds4TAyXQW3/65spDm9AGA2?=
 =?us-ascii?Q?DFnRpKOOS5W9FuDHBhuMs5Fb5jDNxWduzKL+0pB9KFUkDNaQwFyY2rQsbb00?=
 =?us-ascii?Q?npgG3myMq6kkREBhPLtSox6vWD7/x3wsiMctleEpKyuf5yyDwDPNsjHzko6K?=
 =?us-ascii?Q?2A3waEbAW+1gl96kQE73VU3S3IhjzNB/KfVmET2huJepb2NnQZM5fydeoGwE?=
 =?us-ascii?Q?E80VYHb4FEQbCLWcNZOkEyiv0u1frUf5AlhHu3qz+piZv4jfXTLHsW7cw8Fg?=
 =?us-ascii?Q?jyM0e1gRrJRFJ6IR+mehMTtfgNwAa+NS+DD4f4Xwb4W/8G5j0GDtt+UXaoHk?=
 =?us-ascii?Q?bHgxbj0Zp4y6fuVW8sB/P/eMVKBF+XsGdvjC0Vav7v719uE6cY1i+85skdOB?=
 =?us-ascii?Q?bLNBjARdIeWL1lAf1sQDTN1Vzfi+JNqT3Zvl3/QI9ubpssrADOuRdtzGOr+C?=
 =?us-ascii?Q?f1RIDwi79YPH6Tt4709AgAfg3mJ+PnRWUy3J2M/hwrqr0pa/rvnJmtFTEZ5L?=
 =?us-ascii?Q?wrCgY4pJlbPNm0y6RpGl?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bcbf21d-7e5e-4d59-a58f-08dcb02f9bc7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 00:36:10.6104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB5211

On Mon, Jul 29, 2024 at 10:02:01AM GMT, Rob Herring wrote:
> On Mon, Jul 29, 2024 at 08:28:09PM +0800, Inochi Amaoto wrote:
> > On Mon, Jul 29, 2024 at 11:30:20AM GMT, Krzysztof Kozlowski wrote:
> > > On 29/07/2024 09:00, Inochi Amaoto wrote:
> > > >> yamllint warnings/errors:
> > > >>
> > > >> dtschema/dtc warnings/errors:
> > > >> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.example.dtb: dma-router@154: dma-masters: 4294967295 is not of type 'array'
> > > >> 	from schema $id: http://devicetree.org/schemas/dma/sophgo,cv1800-dmamux.yaml#
> > > >> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.example.dtb: dma-router@154: dma-masters: 4294967295 is not of type 'array'
> > > >> 	from schema $id: http://devicetree.org/schemas/dma/sophgo,cv1800-dmamux.yaml#
> > > >> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.example.dtb: dma-router@154: dma-masters: 4294967295 is not of type 'array'
> > > >> 	from schema $id: http://devicetree.org/schemas/dma/dma-router.yaml#
> > > >> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.example.dtb: dma-router@154: dma-masters: 4294967295 is not of type 'array'
> > > >> 	from schema $id: http://devicetree.org/schemas/dma/dma-router.yaml#
> > > >>
> > > > 
> > > > Hi Rob,
> > > > 
> > > > Could you share some suggestions? I can not reproduce this error with
> > > > latest dtschema. I think this is more like a misreporting.
> > > 
> > > You would need dtschema from the master branch, so newer than 2024.05.
> > > 
> > > Best regards,
> > > Krzysztof
> > > 
> > 
> > Is it a must for the type array to have more than 1 element?
> > I have tested the value "<&dmac 0>" and "<&dmac>, <&dmac>".
> > Both pass the check (These value are just for test, not the
> > real hardware).
> > 
> > Setting dma-masters to type "phandle" also has no change. 
> > It do not accept the value "<&dmac>", Is there any suggestion
> > for this? Thanks in advance.
> 
> The issue is 'dma-masters' is also defined as a uint32 in the Spear 
> binding. Types aren't local to a binding, so when there's a 4 byte 
> value, is that a phandle or plain uint32? I'm working on a fix in 
> dtschema for this. It should be committed shortly.
> 
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> 
> Rob

Thanks for the explanation.

Regards,
Inochi.

