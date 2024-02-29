Return-Path: <dmaengine+bounces-1182-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9002A86BF6F
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 04:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6F7FB20DA6
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 03:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565A9374C4;
	Thu, 29 Feb 2024 03:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="txjxZJdu"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2069.outbound.protection.outlook.com [40.92.40.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5FD1D6BD;
	Thu, 29 Feb 2024 03:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709177094; cv=fail; b=uX1/nYgmZMAo4Sv/mR140I1RUFBIr4bmeB2Zod3oXEoqDG5bbaCZkAY5u7UfuOFS83uwUbeuBbr4PjQsQeDzT8GaTeS71ziMFMAD3SYarB36CTZ1IVLixXwEKiB0hCpxbSYYUOtK187sd+BsV3/tPQbDCSjtKyDOmFQP8QXxhYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709177094; c=relaxed/simple;
	bh=wjwFmzv9cc/dnAmUaDQBIxrALa7vXeQS7xCtvzjbtCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kd7YZ99V09G4jrPE+UyU3GdqOEGBUBkPp6ng7p9gi+/j2QU7qvaW9uk4u71c26bmLbIrlW4w9I6ecjTGaru71hF6YYfaebo9Dr/jPSwd39gJq9Xurwj9RN3SxIL+Y66EJ4pObORkENuumuUiYmRA6YRo2l97rvaMvWBjgQ66np8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=txjxZJdu; arc=fail smtp.client-ip=40.92.40.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHDUO45DilgXsaZF/dzs8sCKmTXHQ8xKZiM/S18gBy4j0YL/M37YXPvdYarMfeQez5F119gA2V4L0E+FXqiNeMxKWvm3YY9h/1/Az8olLG1TLd6mTAr9C7ITyQW4HfP7Ob+ZgxuVG/wKGHjcSkamkss6Vrnj3kKlhtAMHJ2OdqsFGxjE05Y7Q4pYyhivkiuR2Ppk2cU20WkzRVHBvLAa7eUQZuLKOVUT/Q67kcNatlEAv4l6MkoXzT3bgwEVNfnstYj66lR1WlZBueeXBzxinBukVZioClL1OwOPSm1kU3qkGtZdhGtRbHk7U5xVAGMWjEwzl4D+i+CwlwYL+FGS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boyNminJAHmL+nwOuwbradsIy5kQxwZLI977q8tx2gI=;
 b=NcYFG+8t7dIVW/egyEBKEUgovjtaf+qzag7rxB9wU2P/xYYtsB3xYUOovgjs8VoDzyBkvcaRrtWyzi/KN2huD+N7RhAskIAg0pVlpyS/xG7QWa/wl7QBYIsQRxrP6ObRe/O3iTeuSnzStt+3IjdGgEaXlT5bNhc8fH+qZRz+wpi6i5ucNNsTjo6nmADMvjIXuU9uKCj+AddFBfn6ISKzcL4LtSaZ82JQpH+exMCwh9JgjbKxyLQAKAkMz/i/NE+VzRlN63UTOUhOQ+m5Ry81I6kj5FC08MjYVsp2OpVNcFFPaboSQ2w5iSX4ezzH8s5fILLCjZ45GvqgfwTUD/LnVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boyNminJAHmL+nwOuwbradsIy5kQxwZLI977q8tx2gI=;
 b=txjxZJdu+DfTcdkyofPbJ3j1VVLpcw6YCiOHp4rNJw3KPuwS3BTEdXdhqM/aZfGDJ2UxBcO8LT4lPtV+cPaupm8JnB6z6LBQX4FRP07onE4Uz/FsGQiyM7dE1vJoZW9U/c0zEIEG3OlLjIj/VkNJQCV1xQlkRPgkscLqhZju18Gpgv7xuHS+ymk7uOLgLwS8mZcud5Ot8GEZzjhmklXnZku61+hATWyXptQv/OTrJf5B4E1XhdkVZNsC52Z1j0svPvjXPrHl1NAlt1JYTpospFwqKjNFPfIsTQxt7uXdy/4K0BkCVHUig71SEGnhiospJFjTnVRQiv6U2zPSUjqU0A==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MW4PR20MB5376.namprd20.prod.outlook.com (2603:10b6:303:222::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 03:24:49 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 03:24:49 +0000
Date: Thu, 29 Feb 2024 11:25:03 +0800
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
 <IA1PR20MB495358468BE74C069811DDA8BB5F2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <PH7PR20MB49624AFE44E26F26490DC827BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
 <PH7PR20MB4962BEA2751F7C45A16E40B9BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
 <20240223003334.GA3981337-robh@kernel.org>
 <IA1PR20MB4953C60F0B70D82922D3AD36BB552@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240228170758.GA282254-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228170758.GA282254-robh@kernel.org>
X-TMN: [Y5RJ2jJ1ZJ30rQeCFTkYfMAL2geWSiHImTB57ZvYxo8=]
X-ClientProxiedBy: TYCP286CA0197.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::11) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <77lm7eco7j4xok7an5lucywq2bmdqzaf6mlbxhkyohsqnov2xc@a57a4ezvy3ec>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MW4PR20MB5376:EE_
X-MS-Office365-Filtering-Correlation-Id: e8671317-c4cb-4392-3242-08dc38d5fbff
X-MS-Exchange-SLBlob-MailProps:
	Om8TgR6f4EAUHQvHeqKkCGYmZREscoAQY18xdJG02eP/D4AnpqqXGwErP+uK0ggOswSci0NfrlIrRRXLUC98tztUbf4xSX36erMyPPAy6MuIuzt+l43q8grG1VaO5/zHwkblScZKZFpq/DIyu8GN8snvRW/a9gD3yntnjWcUL26/1ybxk++DofjkzU4tbxQrcbJrMv7oggRhLLteRJvh1vFuCwUzdYTNvg6tH4jwepE9OQwSYYbYpKNyZjkuDuqYkK5Le2eLf6C896W/ltZlef2/b5sQwwxEdQPlfGwqUfTsDk+ajv5tCFfDw4NEYqFaExBMlMw6rmWewHOm5JL3eyJ9QCJzXfSaJeQ+3R7dV66KCbkfqdjCISPbClR7Vd/Ym4rBsfm6zpgLMExRQHQTS8v6Fn9b+P5ZLyTm8EUrqUoiDweN8IunG48N8/e+uBWvTksejO52SX7dtOyEnmpyM2tTsufpGMiAF6rCXeuKRzYPkfe9UGQKOIiksiIvs0XyceGCgqRb8aNU58dVnqRPfVwp4OjwhU0GBrgd763ouaM00rkd9LqYc43zTg0kSpEwXWYGbQ7BZiX8cubLsDiRgKZqiiNOv42IYXyrG6ze1Ub9BFwq4soLqJn8AjUrqqlndXVlO6Vr11w2+3Oe2NVYRxcbpfmyt0SuCfSSplXk0AjhFrcMIVktnZsG6oHVgdSoxaDo7XpJf5lZMWWG2FCE80uGiwRP3fe5qiDrYoPd2tz6pT4UMXrHwCtvwm5r986YsLP8u6IgBVszB6RmiLc8zDA+qoTCXzk2tTMPxw36c9Gs84T9CK34ynczAZY0GM2do7ptQoOktuBEcJjsY4MUj5HbJgq1i414
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DtXVhWZ+p+iTy4nJ+PQoW6Ps20F440LyzHTDj+IBmMwAgkpfr4D3WefZ2vb0o3xAKgkKvzR+hgiCCZ4OuUyZ+rDl9ocVRRLnYbSwSCSaTdR6ocM2XfhcTzEntDhYFfIByM5y03i76rlLXCGlqcQzQ8u5F8gfYMR4lBFovPD+t0abiS7zQwozVqQUlHMhVB40uk3XwrMPLif8T+sMhL7bFIO21sov25vtczqaxJcu+kjDw+KcYMzXFmW5a3YxeWT43CLAG6otcbPXJdqV4b5faJveY6VuFCDVpx4wPG/alhm8WZV3lAq32wHZpUGj36yvDlhn52XB0wv5tkK0sc5d/Br4BJPSAisO44NNKs7HHbtXFvRbV8FtZo89BpfqR6odRr3ejp0eEa/9MmlLEhzo193amo+6lqDKzPoyq9NteO5NVMNrk9RFUHH5oI91lpRyHDEQBUGJAWDpt8au0AdDw9a7mlqUZdR2OruHWOGGHcD2xgUld/vq9SBEH2mO17Z8ldMW0QPEV3D4PW04YgEHahcPNNwol4SBXhSqzN+mgNqtD1Y/vC5jHFcJx8tF1iCCL3oQ3AoeluYwD59w1v6xHwuh7r3mhYmwk1/W1QQ2JIzOawyrwoWi2hElFbEFmNdjFOgTpnICKX69SNTQKpbp35abxqrG1HhAkWAZBRGeoWiZ2yvHkw9/eNsChYYkBbDh
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X/mW/hzW2Tclo1GkObTzVMCeF9Du2uEujyTq8PBKdBFsGDzuqUj1TTRnCqGy?=
 =?us-ascii?Q?nmvyIby1nXphslieGK1AibEoUcXrFEukVtwQdVWK8XLdKnjeTp0nANNskN13?=
 =?us-ascii?Q?WcVSXftkf57bJxBTrRCklV297DGzYuXzOZLwQeW6UD7wc6SIHqsIWbp8n54L?=
 =?us-ascii?Q?xi0hV7TN+cJYCSI60CpG55KhSZlMEMLSisueVggBj1OMzarB/ZFuceH0LeSH?=
 =?us-ascii?Q?4qIX+dgQ/UPQ+VA0O+glro76be6wnP0MHEoy9SS8sl6OsZNZuUcQxlcXbMvc?=
 =?us-ascii?Q?WlvGKxoKGfcz8QS2XfXtY5RYq7UOqPR4WdQ0kCPMqr2LSK4nPdnYlxgJrBht?=
 =?us-ascii?Q?PvuJtNqLVdDUlXkV6RsfwMLdLE4g3F4yKnlK1QQC1ARrpGilS2UOkUtv8b0q?=
 =?us-ascii?Q?/khnEFn8IjEsFv+6nnsMvzqm+ylSKswZ5JWZTVlCKNFYmAlkBpJAVSVU+KYz?=
 =?us-ascii?Q?nW3mGrZznM1irUmUnu8yFUCDYuPEW8zZcf7kS/79rFdvER0RpT/dcJOVCizl?=
 =?us-ascii?Q?jjAuacYM7cGPI9YyDsDvbAkhVq1WOXeYSyG3vvHAw7n49aD6V9eb3mWC/IE3?=
 =?us-ascii?Q?dW58/4Sau9eTi0JfuPIWyT09tpJbU8w7lcSjZCPxYVPq15Xgg4zuppifVYre?=
 =?us-ascii?Q?SGISL+Zkx0wJ4if8sVeXemtO35a9eWMscAiVdMnwN65I3L2PwhR3kZEzi5WA?=
 =?us-ascii?Q?OsGz4s8M70Am7v/J9KARc1RKQ3bBkGnqhU3Gm/xIZ645/nC9FKrTS0gXwtjS?=
 =?us-ascii?Q?7Cl5sbzjlqgs/zf9xNTZkaSdwExrYH39Q7uhjQOvGWQTU8ZByMAAvVCPcPKj?=
 =?us-ascii?Q?hKbglnksMtmNmDcVCCaaRUIzXUfZdJIyvlrfUAZ5BK2FQFPzo5EWjKaZz4J2?=
 =?us-ascii?Q?xw4NaZidpcVwiQ/LX/Lv3XREgG7vC2w6mykhsG7aH74VvR+SGJzaxXzGuZq+?=
 =?us-ascii?Q?Il7pYW3Cm4fbDNgCMRL4xqioeJYOHDlVYe6VovwSBWMbicMO9rUKsagaZZuL?=
 =?us-ascii?Q?upk+1vloUIvgQIjLdfbI8o91OvdgQrW/NYOWRgoWvCruh8vKAmZPyZ9Vshf+?=
 =?us-ascii?Q?97sQc9AqYcZntIkYiSGY+C58REEXJ+eYDMCVKSJgCBf+m0Kq6n7ztQoVPc9X?=
 =?us-ascii?Q?jrcvcABd6gcMmoV1CTC8z3NMtM+Su/JiHjQ9Zcgla5vp2JYOaoy/dQ6MENwB?=
 =?us-ascii?Q?t9moRuT1/E4RMhavETRG23jeiaA0opeYnzwcs6ITlg7uG48JWNZvLUEu/oyk?=
 =?us-ascii?Q?Bh/O98rBWKdThRI7WcIf?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8671317-c4cb-4392-3242-08dc38d5fbff
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 03:24:48.9036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR20MB5376

On Wed, Feb 28, 2024 at 11:07:58AM -0600, Rob Herring wrote:
> On Fri, Feb 23, 2024 at 09:47:05AM +0800, Inochi Amaoto wrote:
> > On Thu, Feb 22, 2024 at 05:33:34PM -0700, Rob Herring wrote:
> > > On Tue, Feb 20, 2024 at 06:28:59PM +0800, Inochi Amaoto wrote:
> > > > CV18XX/SG200X series SoCs have a special top misc system controller,
> > > > which provides register access for several devices. In addition to
> > > > register access, this system controller also contains some subdevices
> > > > (such as dmamux).
> > > > 
> > > > Add bindings for top misc controller of CV18XX/SG200X series SoC.
> > > > 
> > > > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > > > ---
> > > >  .../soc/sophgo/sophgo,cv1800-top-syscon.yaml  | 48 +++++++++++++++++++
> > > >  1 file changed, 48 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
> > > > new file mode 100644
> > > > index 000000000000..29825fee66d5
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
> > > > @@ -0,0 +1,48 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/soc/sophgo/sophgo,cv1800-top-syscon.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Sophgo CV1800/SG2000 SoC top system controller
> > > > +
> > > > +maintainers:
> > > > +  - Inochi Amaoto <inochiama@outlook.com>
> > > > +
> > > > +description:
> > > > +  The Sophgo CV1800/SG2000 SoC top misc system controller provides
> > > > +  register access to configure related modules.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    items:
> > > > +      - const: sophgo,cv1800-top-syscon
> > > > +      - const: syscon
> > > > +      - const: simple-mfd
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +
> > > > +additionalProperties:
> > > > +  type: object
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    syscon@3000000 {
> > > > +      compatible = "sophgo,cv1800-top-syscon",
> > > > +                   "syscon", "simple-mfd";
> > > > +      reg = <0x03000000 0x1000>;
> > > > +
> > > > +      dma-router {
> > > 
> > > Is there no defined register set you can put in 'reg' here?
> > > 
> > 
> > It has multiple registers in the syscon. But in fact, the dmamux
> > is a virtual device. And the syscon device only have some discrete 
> > registers. This is why I did not put reg. It should access the
> > device using the offset defined in the patch 3.
> 
> I would add:
> 
> reg = <0x154 8>, <0x298 0x4>;

This is what I have done before. :)

> 
> (with appropriate "ranges" in parent)
> 
> No requirement for Linux to use this either.

It seems like that the device should only be described, right?
Also a small question, is it better to add reg-names for this?

> 
> Rob

