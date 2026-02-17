Return-Path: <dmaengine+bounces-8928-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEUoLWGtlGl7GQIAu9opvQ
	(envelope-from <dmaengine+bounces-8928-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 19:03:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D308914EDE8
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 19:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D46A3014A0B
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 18:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EA1293C4E;
	Tue, 17 Feb 2026 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JOSfygK+"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010010.outbound.protection.outlook.com [52.101.69.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CB21A9F91;
	Tue, 17 Feb 2026 18:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771351388; cv=fail; b=UH9GqVFijx55YBrT/AoW1lcazjA8UcC7WQwq/7nvCURGsfWQNueUtYTPj6Rmw8UlndEexL+7GK2aimW4w8Bz/V/0I4WsebeNHfqVCtPAX0V0bxcvC8TeDSYwdHZffMNGgNtPdC0us2OoVmRjTSZoEJkkKvIaScsZLm3pINdR1iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771351388; c=relaxed/simple;
	bh=jujr2ndJj9QT5kCTzqU26NRyCSAdW1HLytVfNX2qgY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y9s8LiZraA6hjOLFH6GcFw+mlQUGNuUvdW5PYEuYb3+YgRLIggtMV+1qmLeAtVdo0lIBMsW2namv7CCuaeUl2nHbaTCGHrqFiRgi1fGvt0VHfoWbDwSDr0VVCZBzeLlSaadZnRjC/G7AG2zAsFX9Ah75+1SPAlcdy46CDXj4oBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JOSfygK+; arc=fail smtp.client-ip=52.101.69.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bflP7bDuagWwesVsgVVjAWJONMucaJUk4UWfF4KYUZd6IDy31Nx0zm1sAYduIc3TNCS9Tzb6hJwdcB1bm6YYC/ooIxq95KirEIIahTZxGLwtwsrOJ9BMdOJUL+uqgzg04/pPb0h2ofJAVReKeXy+qMzDR1a1nZXDOFO2YpIEjBY+670vHldyQ65q8MAJmRgQniiw+pRX0UEEv+32uzf93iHCLzEH/LWhWLu1Ck/HDx9CdNgHuY7afNCXQu7m9BqpvCh4qj+hGfM5cV2iLZlw2mikafCe1qEamOtAEpj9tLF6hRqHQI8A+4K6hMrHDES9BSxrN6czuSuAXl8aIK68aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjSuBEgrKtAxs2oXRn53TlkbJ/RIS7HVqOzb1GoOh4A=;
 b=Rx8+bXxkAf4D1kJVkjqY27taJyFg9laydn7hHu5GvYIf5ia595rN+rv9CMUM3Kae9BsUW76SOyeCEI2fZUsugu+5zA33Skep3MvFhic3bGJlN9J8tORB0btBBmTiS44pA+bcnbrbOH8LxHgnsbVas+2PLAL6slM9iYNPLMX+zzlSG3ZcxjvG3QoaVgSqZdG4BLSqFNlS1gSxSD1kglqjK7ST3ze0Boir6hYLMKjpFLilZJLEgi96uaNVXvjcasD9dNZeYlJxZpry3U1DlnsGLYcIpHmgbl4i9YdxNK0oNtgSyPyq32Rcz6QLPRTB2hlAUKLVJ0R/IUQKkqDg2phKBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjSuBEgrKtAxs2oXRn53TlkbJ/RIS7HVqOzb1GoOh4A=;
 b=JOSfygK+o3ZXv3aUcG0tw3FZWre6yQ/3wEMaKM+7e6/0hZeCksvidyL/GR/vjAkc9L581n/IESEYz4HIAP0jiaWTexLoCYSBZIN9LHNZItxOxljDRh9uulNUMqaSsXAFo42BeNbkPucCQAzh3qbKuH0BTcKTkkyx7FP/zzN6dgK8gDPiQjJ9aRM7PUEIpYo9tLkCufxjCplxDJYP5N0qFEXKDHdIWw1B46Flp8isDHt3QuS5mzryQfk3oFIZTCKVucWVlTmJDB8Pfi/w0r+WPU2rgafpvA1yEpc7SJjUN6gRG1zaFvyfV3ieDaNJsqrHqs1xWtd4qSRGmkhkrJo7BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GVXPR04MB9777.eurprd04.prod.outlook.com (2603:10a6:150:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 18:03:03 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 18:03:02 +0000
Date: Tue, 17 Feb 2026 13:02:54 -0500
From: Frank Li <Frank.li@nxp.com>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	vkoul@kernel.org, Frank.Li@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com,
	jonathanh@nvidia.com, p.zabel@pengutronix.de
Subject: Re: [PATCH 8/8] arm64: tegra: Add iommu-map and enable GPCDMA in
 Tegra264
Message-ID: <aZStTjL8EoZC4TtE@lizhi-Precision-Tower-5810>
References: <20260217173457.18628-1-akhilrajeev@nvidia.com>
 <20260217173457.18628-9-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217173457.18628-9-akhilrajeev@nvidia.com>
X-ClientProxiedBy: PH7P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::33) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GVXPR04MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a65b2e2-bb40-416f-b7b3-08de6e4ecaf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k+M6OD3wHwm+9SQ1XwAeS/HletZmMRkLHWA8fpde5IZmzPa3dvZ1wNIhGcxX?=
 =?us-ascii?Q?Ba95bUEpu8ZDU7z6U4XYxJt5OES6j5VFK9eYWdnCwCX93HMXk6qjRXwFugka?=
 =?us-ascii?Q?/No7cIxI1z9X7socVDZI1syhB2IpCRAcWzNkh+smeKaWmbeHd/kDnGtXk/ON?=
 =?us-ascii?Q?Vt00iEkftTubbhak2E+qogWSMZCVNIa74uIrsDEdVCv8JD6Ndt4Qk+K20BWe?=
 =?us-ascii?Q?ZZ/+yvO5GnYsLFoGG4NpdufWaEafGNwXTL/ttWen+83p1q1RMLrvHUbtY9iA?=
 =?us-ascii?Q?nHl/0U0NQ/sHze1ZHxtKzJYhNIq8SkLVDL7pgOzc1dnWeqzG1zMm14kcX2X/?=
 =?us-ascii?Q?Z0R4t3neGzgsD3Xl/3WAVAdodu3ObZ87DYGtnXSYtMs/d05jmHXNq9DefIIU?=
 =?us-ascii?Q?fZMyNo3j3u7xcqvzzTMITYkrqRdNIVqJN2MIogwXdSoCMnXYu08g+0v9FFZJ?=
 =?us-ascii?Q?fJcR2H0p/WVz1NYOTQtFEXlfnFXXE81s6V1TjTrsDB37c1DXcR2D0FGi1WXR?=
 =?us-ascii?Q?oqKGtY9MoQwkGdAeCysP0+QyZaUXmAMuyuKLjCjBfWbCCHiF4dka8lqk9J+l?=
 =?us-ascii?Q?Uxc6sBO270jU2ngdoJxAuz2XQrSORW/pXa3ousfPr52JnmfSSWg9qu63bYJz?=
 =?us-ascii?Q?sb+Nju83l7suV+F4a9LWIpGC1myhvAGPBCsRPlb3fl12EyiibBvoQOkwihlg?=
 =?us-ascii?Q?UREEL1IjYdDgiokmU/m9TwLVVl4iLDhmKJBlCs/HAZNIiAPlwhgVtuD/OqSK?=
 =?us-ascii?Q?+fzLplNYlK6B7MesaWTnXC+XyyZmYWCM4yaSeToTfusmomLHhKp/Xg7e5rzo?=
 =?us-ascii?Q?afGbV+hHyeRHvTnOJPpb+VHOw2m3qDH/pYr3Pqtb/0DClTpC1MkTdc0qiLEK?=
 =?us-ascii?Q?Zfva+12pjmgMbUP1JLYzKfcaQ40vGEr9RP2eCGF8MX+5ZPMSdB16gI+Mu1wo?=
 =?us-ascii?Q?ucIfBlZHjTEqCJEbNRAkoWkf34Z0CuxSxCJ8wWLLI92JzQUlKFww07aYRDCP?=
 =?us-ascii?Q?4oBW5QgZxhr5ct0dJAHNQy4LwFuUd25h+rI9feMPKNBcdEkk4exMeBqXySD5?=
 =?us-ascii?Q?jwWKDF7f97vg/4+w0B/u3apcqAOoWPiy6W5BM3BM1SWmPB74vgVsT/TQySOB?=
 =?us-ascii?Q?iLMtZcwHqji6nXtTSvlOuhRCVzY8ctuVhTNrlXrwzXxorpIeRKncdIUpWRdr?=
 =?us-ascii?Q?1dudhreA+48w90oUescMP032Js9IgkG2t1vy0zOpOM+SCTD+LGTK4yWM3NDH?=
 =?us-ascii?Q?ZYrAmAI84qVbjczrX4HRAtwhb7PH/zyTAfTdDaNyxcrN3AEANwsbz+pOWQyg?=
 =?us-ascii?Q?v9NElf9Jz2z31F/mBs9u4sMRIdBrN7cOHR3Fy42Ps5oToMtmKcsANOQkJrFs?=
 =?us-ascii?Q?had3oGDALfUBxqvfBPcE4JpRlSmhs2GyH8yjhEnQ1WjYOYNVndH6rU6hh2az?=
 =?us-ascii?Q?24TrpiAV1mFsrVDfkYmrpqFB7UFK9rZuNn4c4zofTW263YD4TZjWS65ET1Rn?=
 =?us-ascii?Q?jihJCSCUhKe5o7yZ8b8JTEz10fJZ7GxZcgiTguzzF2JcraEFSucVXCJiVtd3?=
 =?us-ascii?Q?GZKS73/Msa/VBpxYNQMKHxT16Txgd7atMnE3YkZqxL1dZva9tLU4AU+N/upz?=
 =?us-ascii?Q?VL+yXs29phL7jdYSAlbOXsc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jb9BhzlkebzqSpm4qW6SH7/36OIL2x4dCADsg30LjoMXuB7v0XwQPd2B8BXv?=
 =?us-ascii?Q?3KWpZ/t9VaZkhkTfoxGPDacMA8Twb4B63OzmU7bmb8JmmTQqH3teQNhjsSqv?=
 =?us-ascii?Q?2JP0O6Dffn5GGTG7a+HFABerztIMJJmmdZGoF1mlMmBDoPMzfh9cTuymO9IB?=
 =?us-ascii?Q?WtbtEFz6dEjeFIEBTCpiGKiC9REFmcXyTFtz+z5psaCFTDvLa+2HXURNUcmc?=
 =?us-ascii?Q?S3Kbn+IGRYrlVJBIJ3xnF5MjacQ1yu3jrk17wMOnASPtLhklqKIzCmfNIBnQ?=
 =?us-ascii?Q?9Jc6y4tw7lw0AmhYo6qSbP8cll7clMrNxsg8hC4RJLOaeP13vH6EeKd9r/j7?=
 =?us-ascii?Q?DhSJ8+myVqRwG4oePSBong0P8v0kOpm0ye2LRzOUn2y/auB04dClcQ5VuLa5?=
 =?us-ascii?Q?fsGoqdvoQT6i/UtGU4qUJETESbFETDeEIX2a16TzHywa1WNKhDzXSjBNC2yL?=
 =?us-ascii?Q?CgXTOioglWdd9zk5yYmniGQlSBHWn7cchvY3vSwBrRvISiwDlKICJo/9ZIxb?=
 =?us-ascii?Q?HKD+E0sRfSSZ6uzvm/tlXs/xvqaRFsb7ssKEZLvNp5CgKmTzDvbAk9Bu2OO/?=
 =?us-ascii?Q?D/WwuapUsc5jgHQXSi7pVduud/5HMbf/7d+pt2hcsNQWra7w1GmFMKk3mJUs?=
 =?us-ascii?Q?SfvJwSnu098FQcHGDMfBS9JmhFk5xWDPG2omDvo4tm9DLcaqkoH7r30Cc4rH?=
 =?us-ascii?Q?/sW7hRCbUkVjYffEz7p+bdP7vWMd2DE0+rMeQkMIGu/XeH08pvuZ46RMrutF?=
 =?us-ascii?Q?7Jh5NNVwiqP2MRlrHQtBqqmpBxfWEjME7vDyEhJ8TIq5ejekrhpFxc5m1XKN?=
 =?us-ascii?Q?vksR0EUJAuSc4Ncw4smQ27jDtEtDVsg0mbpdGC4E+sfmaew8bLzoXwZU6vus?=
 =?us-ascii?Q?2UObMeyl8KgOt8LtJPJYqFsjHPeaD+wFV0yWClr4tV7lM95uFh8aLPN55s+l?=
 =?us-ascii?Q?A4AgHjVVW0h+JdlYKJF/y3bKh61GuTRn1RiOsCo1ZH1PrSt3HAstHeCQQToo?=
 =?us-ascii?Q?ImWJeBoeoROGocBiTwVd9NyiUHMGUfINnER8iM+VnJ9hQMw9cx0T7booR1JB?=
 =?us-ascii?Q?09e2nf4OiQCiXWej6dySkR6RulSAOyHQM+Xzrq0ghPSAbUhmkFyaV5FXTvFx?=
 =?us-ascii?Q?9itqoL4JaC6szzkAwbCWZb2ZT8P22UIolDn7kMDqwChAbXreliU+ToJXJBCu?=
 =?us-ascii?Q?q8ugUJ8UkRvl7qUjlEXGfHTdFHROZZZcZUeICPHenWd7YZUqN9/9gJ36xl/U?=
 =?us-ascii?Q?D8IQmL2iemYTOGWWyEna6QvqNwHKk7MReM8tlSoNlqI4xNXoA2ciPBKSjAXN?=
 =?us-ascii?Q?WMzj60S2nokigE/qBi8cnt+aTFM51ue7Dn8DgIaCI4iUTZRMqAG8TSViSKy6?=
 =?us-ascii?Q?6Ys9OOmKVhtbvA1PHs3GtqMD2YUURjntMUO3NJmcfPvkcyMPucpOjL1b+6PM?=
 =?us-ascii?Q?HK7sclw9PL14D0Q5iNhDaomh77nCjuhiio1fAhoLUvj7jUWhKSc2+BVqZOjX?=
 =?us-ascii?Q?VBniDD5gxG9+amYPeHLc937rY61hMU6XxHz5zZui6AyS3RqHKj+xVzWwcWxh?=
 =?us-ascii?Q?rEVPtZUuZ8y/6Hevz/adtpszEPkqYduPATcZxsPOe+cBU1wcuv9qa4uZZtPW?=
 =?us-ascii?Q?usLWR2b9oUgAKgfLPLglAXpRjVK2YouDNPJknc0spTS3SUYjUvGZ+JAtJpNN?=
 =?us-ascii?Q?EV1n3FPAqQ0NzeFAH3INHZW9fXKhh2O+qiKP7y7XsXkHSH6kOI6R3iczqmLY?=
 =?us-ascii?Q?ZMTR7v/Fhw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a65b2e2-bb40-416f-b7b3-08de6e4ecaf7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 18:03:02.8200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0otTbtjOTIFsy02zFM4aJ1V9gx4xCpshfk+TmNB7Gvf/cOSQf3htvpRCg3szPRYorRU96lbYB7SAMkJGzAAeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9777
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8928-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,nvidia.com,pengutronix.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	DBL_PROHIBIT(0.00)[226.204.49.0:email];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,c4e0000:email,0.128.44.128:email,nxp.com:dkim,nvidia.com:email,c5a0000:email]
X-Rspamd-Queue-Id: D308914EDE8
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 11:04:57PM +0530, Akhil R wrote:
> Add iommu-map and remove iommus in the GPCDMA controller node so
> that each channel uses separate stream ID and gets its own IOMMU
> domain for memory. Also enable GPCDMA for Tegra264.
>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>  .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |  4 +++
>  arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 33 ++++++++++++++++++-
>  2 files changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
> index 7e2c3e66c2ab..c8beb616964a 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
> @@ -16,6 +16,10 @@ serial@c4e0000 {
>  		serial@c5a0000 {
>  			status = "okay";
>  		};
> +
> +		dma-controller@8400000 {
> +			status = "okay";
> +		};
>  	};
>
>  	bus@8100000000 {
> diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> index 7644a41d5f72..0317418c95d3 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> @@ -3243,7 +3243,38 @@ gpcdma: dma-controller@8400000 {
>  				     <GIC_SPI 614 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 615 IRQ_TYPE_LEVEL_HIGH>;
>  			#dma-cells = <1>;
> -			iommus = <&smmu1 0x00000800>;
> +			iommu-map =
> +				<1  &smmu1 0x801 1>,
> +				<2  &smmu1 0x802 1>,
> +				<3  &smmu1 0x803 1>,
> +				<4  &smmu1 0x804 1>,
> +				<5  &smmu1 0x805 1>,
> +				<6  &smmu1 0x806 1>,
> +				<7  &smmu1 0x807 1>,
> +				<8  &smmu1 0x808 1>,
> +				<9  &smmu1 0x809 1>,
> +				<10 &smmu1 0x80a 1>,
> +				<11 &smmu1 0x80b 1>,
> +				<12 &smmu1 0x80c 1>,
> +				<13 &smmu1 0x80d 1>,
> +				<14 &smmu1 0x80e 1>,
> +				<15 &smmu1 0x80f 1>,
> +				<16 &smmu1 0x810 1>,
> +				<17 &smmu1 0x811 1>,
> +				<18 &smmu1 0x812 1>,
> +				<19 &smmu1 0x813 1>,
> +				<20 &smmu1 0x814 1>,
> +				<21 &smmu1 0x815 1>,
> +				<22 &smmu1 0x816 1>,
> +				<23 &smmu1 0x817 1>,
> +				<24 &smmu1 0x818 1>,
> +				<25 &smmu1 0x819 1>,
> +				<26 &smmu1 0x81a 1>,
> +				<27 &smmu1 0x81b 1>,
> +				<28 &smmu1 0x81c 1>,
> +				<29 &smmu1 0x81d 1>,
> +				<30 &smmu1 0x81e 1>,
> +				<31 &smmu1 0x81f 1>;

It is linear increase
<1 &smmu1 0x801 31>;

Frank

>  			dma-coherent;
>  			dma-channel-mask = <0xfffffffe>;
>  			status = "disabled";
> --
> 2.50.1
>

