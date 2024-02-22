Return-Path: <dmaengine+bounces-1061-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0D685EEC2
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 02:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073E21C217CC
	for <lists+dmaengine@lfdr.de>; Thu, 22 Feb 2024 01:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A3712E49;
	Thu, 22 Feb 2024 01:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="RBT9Js7N"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2104.outbound.protection.outlook.com [40.92.23.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5737980C;
	Thu, 22 Feb 2024 01:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708566497; cv=fail; b=lQT7SrvsGN7c0/3d2IPoJ8X8l4pFbS25y4VtfstzunBEKfvxAy791nSAXYFSXkbGSrvOufV3UIjptWmUGLFNN4FyVeP44oQ9/fYMTdbxEF3mWGVWeaHkjC6jPi61CsMVRf8N79HDvSTp596lSHb2ZjIM+UzY+RkPMOmEuc//5Oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708566497; c=relaxed/simple;
	bh=g5R1cha36IEfFVNkqQ6FWt+Zqi4eNVwR/7X8Xol9bf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QouJCSKdf3NP3yhfy/3PUt0ig+nc2/exWwap/5kGYjtAhxMl0ClASzoAqzh405maJVt+6ysmj3C+gdHKaYo3OKnfYrHSfy1L0nuQ4ggbLsrXbZDsSUTqgbHpqeQj9rsVKMyBopymp7Qt8PyYuA+7MnMSBpEqPCxhovmmKDdbnxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=RBT9Js7N; arc=fail smtp.client-ip=40.92.23.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2V/PD0/lM8FYi8oI6flALbHvA6wB5TudmkKqvg+dv4NdrwT6Z/XxSsoy8RIoeRsf73pH51e8gtCjUmF1UZ/yJCnJFVUq1o42f5Rda5zjbLKarI8kxMOoizhN+emn8U65yzaGQKKesEuhPVIrW1NvlMadnsmiakts+HtDI4GCTvNfa6+vV6NCxVF3GF3n/JlhBdcf/mT+xMJwsCS5IyRidnw1zGMzK+0evr21cZHvA6NDbs9htj5UrZCj2wQjXjhuLWhPPjhNzClF11EDx74cXmzTSJs2XDn9kcL5vUR2Egmkpphi6XnkPaRgY4hlpg917BOpx5JvZi7Rhc7xn+QbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRabBYA2helfeV5o1FHOkKnq4Dus4GKGoXleSMX2+TM=;
 b=HyqsbXyLNFnGvhrHR81q93HN3U9PsVdtYAyKEC6f4WwLNle5j2SIc7MrXJTHlWV+ZGH+vrrUPj+KAtGeDT69opauQz2i+H6KCBuR09rOIhiRHrBY85H7kuOoOSgdBzAdnFPVxhOlnz2QJnVUN4SvZ2hMXkwmhEocWBvTCaT/INFiLr4gyfiXciW4PZ1h20GSRKjaqVIIC9GzXjDRS9gbwJqsWgpzUFCRFJU9NqA6jAN3k6m24rne/P6aXkTuKTZ205pP6IaGw7QmG0kgpx5yWYaPg6+E7353jD9hACrCaG+yrnI0C77pGmbmlVglJ5RbLkThHFbEvOorMjCYu8bhKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRabBYA2helfeV5o1FHOkKnq4Dus4GKGoXleSMX2+TM=;
 b=RBT9Js7NninnBHzTNM/85YNWxmSMR1bx1gFAIl+zpIfAXuRJ7qStnO0u8mNCzvfvBlqmUq6AYwb1DlZh7klBsjJ2MQL2a5A6dfbngB2+0VwS90ZwjQr3MC0ZMN6alja423CIVWGMnOEiS0MaeRJMcK6dHzlijRJ5cPYDZ3pA3iWABK0rZg8h7mOKnunPWsBM2VQV9s7Ls7TOvtADzINkpXs1CdGEsUpX80V5V4PXJrMLZS8rvPZEbuLfTaC3JzDMlW0sRYYdqccZjtES+mYfHvYKu3uK+AvwAg8lkQVW6IrXEsVqOkrQV1RSSkbnz6irY9XDK9XnWSYO6L1C2Yhz/Q==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SN7PR20MB5264.namprd20.prod.outlook.com (2603:10b6:806:263::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 01:48:13 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 01:48:13 +0000
Date: Thu, 22 Feb 2024 09:48:19 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh@kernel.org>, Inochi Amaoto <inochiama@outlook.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, dmaengine@vger.kernel.org, dlan@gentoo.org, 
	Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: clock: sophgo: Add top misc controller
 of CV18XX/SG200X series SoC
Message-ID:
 <IA1PR20MB4953B531E17F407F839E1354BB562@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <PH7PR20MB49624130A5D0B71599D76358BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
 <PH7PR20MB4962823548BE1CB8E225ED09BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
 <170842776103.2697493.3548601402716430308.robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170842776103.2697493.3548601402716430308.robh@kernel.org>
X-TMN: [bYaAFvKtx5rQz048ukhXdcCo92KkYcQF/zq8gycJcfw=]
X-ClientProxiedBy: SG2P153CA0038.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::7)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <nt6paucfvsak6nan7brj23u7okbb4nzzwc6v4wy7xrjdjggena@rlambuk6urkq>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SN7PR20MB5264:EE_
X-MS-Office365-Filtering-Correlation-Id: cb0e8a20-fb1d-4097-e2df-08dc334854b5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HInfWzvnNf8DDz9tS21UUVoQLhU0wtWxt0ztb/rkLURogSSxfZNcoXT3FOKPnHOwu+RcBtWmTR4o8DycqTSd2dyBGyK+J1QIVyhPyMR8QZQFFvtSYL1HN6FJ4szCCRSeRFY4NnpYD2FiJMPAR+umehscz/tFLQKoh/qKv9+FWFPmFo6Oa7V3dRlMCaevpH74dyiGzd3v01jvRQZ3fe/nVkTzhAGHFL3Hhk3U8dxokltssWi2nsEBlMU3gMT6t/7tBnHs/WeJwOZfFRVwD6ooZ/hHuGxl9qV0tDGODlghc8sGxMXrOIIOwcVMmVh5EN6/lEh/0E2AgSgZ1jfVT3ycK9VonIfYpZRNKYeYmQ9TVEPChI+dIMYw5ATBta5ABDe1XBzttySO3s4ZucFCc950ZJ+ZJHgzJlVW4WqZuzJDWgo0PdXy7cnN4fzcsEHyd8F4G8hpGHFuZzmRJAQZTkWBIYHaPF5/t8p1RNB1HVuhr+JvsqGS1WhG9b9/251Q2BkNL7i1PFEC3CVAle6vQX9USXfUbU9hiATkeyTZAB0OnJz/32t3L0jpztfEm19yQDKW3+WfhyDRPpjHR3btoFjQW6iATWjvEmk54khQztsEOG+bNyGt01jCdd8dOSr+jetv
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VTrjDISYBIwl/1dgpvHPDbsYNUqrCQg6p+k3vP7YaiuyXl41wDKOCDX5QlQU?=
 =?us-ascii?Q?VxyV6orST4ZkBhPxRsz8c+nLH/xSu60NqOPlQbGy4vHP/LmAQdvSStYfbZPi?=
 =?us-ascii?Q?fitnociWwjp3jxltpPt54BiLWgwnIbWzIucvPt9Qki7JumK4s1/+4tcIDiRj?=
 =?us-ascii?Q?pmgzizWZU4DcLWP1xJmsurUXf2OptbC2vzVDhwcOKtFrC6F+61r9fKYX+SRU?=
 =?us-ascii?Q?0MnyCCZwmcUr5CtJ3ZUSTxdcAt1KqYoZ+z1rW4onrKSziJAKCFL76bZzh53x?=
 =?us-ascii?Q?C4dbDpbaET8dPa6rMBEDFhDrIQcPKS7aHXdXv/50WYThCb8e+nPAqu7HApYw?=
 =?us-ascii?Q?U8Wo/CBqyGDBpq7Of64aPd/pm9P6NS8pn4rzaNtWC3HDzTnRpVrChCaYgWFC?=
 =?us-ascii?Q?PeI1Fx6CFzkZm9WRuft8+aXbJ8WFeAelmIT9udII9barE8++sHCFtuauNAts?=
 =?us-ascii?Q?N6IdWEIouc58VvkrwDf4LUTQzQs0sJHmolxZY/Fj7TzlBXXKbbPoyLhvlLii?=
 =?us-ascii?Q?gjJZ4hCn981EvLsZyuvK2uyHwMv0Ax1Y+5Lh3j8Gbvbu3sb0/QZDmPHcBkF6?=
 =?us-ascii?Q?n+DmNRMqqdwjLCImUOxbfmduJy4PulTYPSA80fQHwHgF9hjaUNVVREsv5MvU?=
 =?us-ascii?Q?VADN+CSfcEH0XgjsEmge7Rh/NPr/iq5nKfC+bPs4xToPDsS4TlBRJIibrG/S?=
 =?us-ascii?Q?xPq53h6rce1k2ApLnksQycRHBGiF1Vxt1mTXmOoHeziJSFc1yMRTFqz0h679?=
 =?us-ascii?Q?2bTq2LE5i05ByfkElv5fmfFFD86OQJgTi9JBpB30HuJOsikPDpanD1PU2pzQ?=
 =?us-ascii?Q?dNQON528+jBXA4e78StGmkFzGlPhp+Celhm8WvZJl7ZLKGywdJruUsFPC5ww?=
 =?us-ascii?Q?39fUvKlfsl6Gm54gw2Q7pgoSt9lj1+GCBx8fg1A8DA9WEfMYAzCgMnlV8LZx?=
 =?us-ascii?Q?PpTJ7V73s8MetS13n7N/5WxsQ6abEnjpo40boYbt13QbkEmC1mAhN6tQZA/Y?=
 =?us-ascii?Q?NcSuzX3YnvU3y8OeTNp2GNwE9bnpnPdY6Qn1X08L05gai9ZS+qyBHrghD1xw?=
 =?us-ascii?Q?DXvminR15CWtbFfqNgMjlfcwqmfow8wQnbsxwh2Eu+B55YM4tDATwIULy8Rc?=
 =?us-ascii?Q?wUuHMG4RuN0LlIuE2X4zlUuNGg3JUwALx+XL5PTpZYM/szxCv33dkR3br/FF?=
 =?us-ascii?Q?kQqXwnFhUuaA2CCQadvbVMVb91hsauMGICKZGQ558YLJTnS5TQwjyBJYPWZ6?=
 =?us-ascii?Q?aTVzVlI3mkl247hhB6qo?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0e8a20-fb1d-4097-e2df-08dc334854b5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 01:48:13.3663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR20MB5264

On Tue, Feb 20, 2024 at 05:16:02AM -0600, Rob Herring wrote:
> 
> On Tue, 20 Feb 2024 18:20:29 +0800, Inochi Amaoto wrote:
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
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.example.dtb: /example-0/syscon@3000000/dma-router: failed to match any schema with compatible: ['sophgo,cv1800-dmamux']
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/PH7PR20MB4962823548BE1CB8E225ED09BB502@PH7PR20MB4962.namprd20.prod.outlook.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

This patch should be tested with patch 1. Maybe your bot lost this.

