Return-Path: <dmaengine+bounces-8093-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B12CFE89F
	for <lists+dmaengine@lfdr.de>; Wed, 07 Jan 2026 16:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 010D23012670
	for <lists+dmaengine@lfdr.de>; Wed,  7 Jan 2026 15:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5021B33FE1A;
	Wed,  7 Jan 2026 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="f5OUX8BE"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020143.outbound.protection.outlook.com [52.101.228.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F286533F8A8;
	Wed,  7 Jan 2026 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767798805; cv=fail; b=MCiNo6f+8qT+GKVnUTU3pMuT+PcZaW0steMlW9E+hW9dozbKgtIGyIImvH3E6mlX4FJjDx8HJLpJH6uStVFDZDnqUzgT8ATdCWplFf40Zb/gFckMO+IhWrH6c8IEnuYQwC82IU6gz2XOyDVQzAAWYsuzwK9m1ojRjWgKGF/tQxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767798805; c=relaxed/simple;
	bh=RpY8/E5TsLiMruP9PDLBVKGGMnGZN6saIkXc32d+7FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uec4E1iXcowUBNUM5TZ5hRGKtOiPe8Nbhbcdaz9Ggt5ugd4wJwvTQsxHaTi0yza65JW6oLyoDwTcgUHxptRG8QZJMkCPW33pdu0jEwor4iIHBJlGektf3Lx3PsLwZaH8Yo4R1w6IZDdXkBYp6u2PgOCs6UqDiIU2iIrl1eRlTvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=f5OUX8BE; arc=fail smtp.client-ip=52.101.228.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBBFXSsfD1PoNJkbPstLriGwFCVCNx6jIKcyTgkMJB32mnoJqXO6/ZhvsSzLT3h1TS0bJxPyBNO1UCklDnnt1cwbys3IOHMn3ZubkpzOn8SuED1vnPZUXKyK0gDrFY3BmHk1sS9e7v3UxB1ViXhoGHnHC+fJaaQZg3rf/V5V6PMCsFlsJitCiybe60aZ2obrqDv5wZSbnK5WcMngLpvrjUXJVdXM5jLOVKPax2HmS2qeHb8+dtlEARbLZaUd0e/sfQ0B90Xc2bY8dc2z/0zdoDX3ogiAzG4DYAnQ9BMAxwV3q6dzKlpCQKWEkegbDKuJ4p+H+s392bcN7cJfSw3Mug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wl/YeUnhSCcKLEJxoTd5kxaEDSvUs5PMtEB1hvTrasA=;
 b=T3CucvoAhJPin9sh6RDZgWn7QbN++koha+JDfcSYfqP01/BJLTbqQXqfXiQNO2yM4s/IU0RIqc0X7Vrx3ZyWyLW2BVudFFbmn62SVhBO88BRraMhstItsIN+BNCcuxzVcxxmuLlepJdSZnQwDSt31ywAJPE/aWq04zRTroRNMHRiiBq8pwKPPgT39n9LEBFh7jPnDgoWTGhljtl0MNybfGnzD6zP6osI3B6833RwKjoEzXl3KQtWgUKA/hxIwjpMVEwf1aLJCZmXtfrRai5HUdYGyrpXuNfpYfx5etb30TFQNJ28z5lxX65zm7p43HyAKNLeNZHUQ9aybId+QTnOcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wl/YeUnhSCcKLEJxoTd5kxaEDSvUs5PMtEB1hvTrasA=;
 b=f5OUX8BEhvJBO/umDbuJTlKruTFPuRhQVCnAHIONYzSwqaJYFwbpUiJg4ar9aRFcrzcXjY6LsDn+qpSsz1OTFUDO6JVgdYlNthR91VDS6+83KPuck3ktFiIAcIZQ1tsoHXVMbjKDO3twJBin1HTgpU0vc0rFrizrBFCxc/+FTDM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2618.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 15:13:20 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 15:13:20 +0000
Date: Thu, 8 Jan 2026 00:13:19 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>
Cc: "Frank.Li@nxp.com" <Frank.Li@nxp.com>, 
	"ntb@lists.linux.dev" <ntb@lists.linux.dev>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mani@kernel.org" <mani@kernel.org>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "kishon@kernel.org" <kishon@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"geert+renesas@glider.be" <geert+renesas@glider.be>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>, 
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, 
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>, 
	"allenbh@gmail.com" <allenbh@gmail.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"Basavaraj.Natikar@amd.com" <Basavaraj.Natikar@amd.com>, "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>, 
	"kurt.schwemmer@microsemi.com" <kurt.schwemmer@microsemi.com>, "logang@deltatee.com" <logang@deltatee.com>, 
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"utkarsh02t@gmail.com" <utkarsh02t@gmail.com>, "jbrunet@baylibre.com" <jbrunet@baylibre.com>, 
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, 
	"elfring@users.sourceforge.net" <elfring@users.sourceforge.net>
Subject: Re: [RFC PATCH v3 35/35] Documentation: driver-api: ntb: Document
 remote eDMA transport backend
Message-ID: <r4usafc6dmzdysypyycantypikzk2vqs2rvubbs7qnm7ad6k4t@qudeqfafzsjm>
References: <20251217151609.3162665-1-den@valinux.co.jp>
 <20251217151609.3162665-36-den@valinux.co.jp>
 <77ae1b02-ff32-4694-9b34-bc49c85c6c82@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77ae1b02-ff32-4694-9b34-bc49c85c6c82@intel.com>
X-ClientProxiedBy: TYCP286CA0055.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2618:EE_
X-MS-Office365-Filtering-Correlation-Id: 78bc39fe-9c73-4f24-61bc-08de4dff4b0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|10070799003|376014|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eEaayL2Zi76weANX73n0tTKsfzZ4oDQ+9ua9vXd/ne0jqcUjca6cX5TwcuHz?=
 =?us-ascii?Q?Q9ksSTXq63mWOOWo+HMqett6PMZtR/HbD4ozRmVGkiQM8RsU+dIL8v25nPFC?=
 =?us-ascii?Q?j1Ch1zi4R6NqCyPFE2gcYf+5GgNPQkXdvsYOfjVcVOcJ7LEGoaHNZid9aAu5?=
 =?us-ascii?Q?5/P3Xoc+du3/rnMM/jWys6CGWAeAsmIEuasa7SdXI1n878cRFJiNGJxZ+osN?=
 =?us-ascii?Q?IlkDMV5zrillIX7ivF1SshVbrhM/hIf1wCNiAzLIXhel0sa6VNAvpTfNvRdr?=
 =?us-ascii?Q?kcvKUg0DxhOuAMbEv41J3PmD832YBX1a6RpuWAfJjOxJCjMTJUP0WAdhZYCg?=
 =?us-ascii?Q?hEEDJneQzCIaCqGKV4p9b4QEcX6n+xNYPtL40Qzj2kbjHYgz9uR+r5pw6rZy?=
 =?us-ascii?Q?fhGHjvcpHdgWpSCFjgD/RQ/XzlpT0y6+24lgZGesIxGxNDVyK8YKL3Zi9OU/?=
 =?us-ascii?Q?q5lublotASgGIXChk2JIfM/MJ2KMaPBThEFWc+YK9J3yeNlBTuB9L34xzj28?=
 =?us-ascii?Q?hL7EGBNZ/xC2+R0I/mk7UcvFsMM3lracKIe3+PcPMGx7GfWBMyMMZnqIfoJH?=
 =?us-ascii?Q?JadC7pLJBKDaEmAg6RBw1nuv8GyfKAhIkuw+AfqWlPytoSdF/wyobk+ubjeR?=
 =?us-ascii?Q?XNCT7wqYj76UdZ7J7QQUORkc8Yi83bMSDLr1um8SyMflAhimzZOXPkTP2vKq?=
 =?us-ascii?Q?FQZPlpXv0XskT8inUlP6NMtiUrVL0o7LEHN7cH+EEcPl/YEdWqZ9x/M12UtC?=
 =?us-ascii?Q?OQ0vbyAxJiQW9VSjSiyezepxO28jzIQ266WWdYbYdU/oRXUvk6pwO3mmfUxN?=
 =?us-ascii?Q?+DaYFm2OjSuSFHNix62kliFlPqcpI9xKA0rJBIiKlMGgJboyv/RivzsI1Fld?=
 =?us-ascii?Q?TRGVXYiiUpq8LmfCmxE83fy2xH+Vxx0Vh6m58t7Byq5I7alITD2OspisBrPe?=
 =?us-ascii?Q?kqsOzrD/Sxuim+q/E+2Vx5cbJJqQTIshXgaoxwPv+ThVQniaCRwbWi+mEt9p?=
 =?us-ascii?Q?AaqTKsrWIIadSmD2iXNZGiowawMnWF4W7JwABXWEx2slcFIZ/G9TUTAZ55A/?=
 =?us-ascii?Q?eYWiiQNbjGz8uqq+FgsiRRpUCV4T8rX6jjKoAwbyn/pqgmVrXPdzzLIAxTIv?=
 =?us-ascii?Q?q5L/qPagsjnGMf9LXQCUiEujl9oRl0Xxy5GzozDzHWs3xBfIV3E+SrWpdeey?=
 =?us-ascii?Q?RECQoeE2bcaR9mU4AvVmXRQv1FhS9xraRdmL4I1o0bUkWMWlFXfHh9YHEDDX?=
 =?us-ascii?Q?V30bAFXSAudlMGaz8pgIcp1qqREeGE+2gc6k6A7b2r7RMTBaPH+5Bdwlz1bU?=
 =?us-ascii?Q?AR1BalBkpS6thruihmJn9Vj8bqnIirnT+3W5C0+FIsg3S10jPQZLY2Sm4eEt?=
 =?us-ascii?Q?K07oKlFYfHfDBxRL/wYXZkofQ9p5tyDaoHQksA6C+arku37F5g2CDSny/I5M?=
 =?us-ascii?Q?lOO89UWcjgJ866QK+B60PLWFzzJzAceeHUisVFBRApNc9+5Ayyx2AxU30dVm?=
 =?us-ascii?Q?Hw2q3W7DoGMNWrxus8126ailfxt6EOHnmZn6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(10070799003)(376014)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8kOUDN5PidPUvrtHN57GPWg86V0x553UjyE6SuFifGTSqWXTC2vsuMy9NfvC?=
 =?us-ascii?Q?Gy69/ZbypR17on3eZQjJZcrrMbFjVfUPmnoS3JrFguSwXGx092tE6jHyagUA?=
 =?us-ascii?Q?1TAQvTt00MUFAUwp5GYocEGraDYIG6eeSm1JrtK5F5DUoknb7KYavmyYv3Qa?=
 =?us-ascii?Q?5Lf50p7E/P0gI8xQ3inJJoFme4muGnmZ8LjugdLCD9oRBMTURRY0LYmfsIx9?=
 =?us-ascii?Q?3zChGR6WOdJjuR3L0R/02IJ4isWkosmPcDVIZvOyNdzqvLwvUSuiexHoCE8s?=
 =?us-ascii?Q?N/rSacZkYHrPWNjFzh1j3eC119NEzzY1qlymVuUEvO5lieQcr+1GVy5spSRp?=
 =?us-ascii?Q?me9xo9eTFWp7Njsd2sc65uiIq/PLqF/rFUI6ksOSArPEyOttnZ4bv3Tru5Gu?=
 =?us-ascii?Q?wFNmgz0fh8fWx8NWJ5UlAp1koL31s/ADOLsKDNdD8z0C/kaErBvwvHhaKRDi?=
 =?us-ascii?Q?g/YhDbTTAn2OQvMro1gwdz/nyquExvE3RUweoUxnMCZPqvwEIqxv6Ynwk+hS?=
 =?us-ascii?Q?SCtHzHba+lUIrU20oJ1KGG3Rd4sFi5zTtGnWrjxTs/pye0sdh0bg7qGh4vrS?=
 =?us-ascii?Q?HxcNYiIFMYaa5n4rtVM9/UXsPg83inwH894RVnPZoXDPVOc+w4/0piJB/byJ?=
 =?us-ascii?Q?0oX1+6fgM5Btf1F02M3hMwuXlW9YQJkyZCVnO1u0ZODFEUtvealQLSJPK8Y+?=
 =?us-ascii?Q?XvKJOdhqac6H2GpUKLOQ+3mrfkcUtqCnf6nCHRNlAzHs8DowXITC1ah3aF58?=
 =?us-ascii?Q?Yx/H767Tz/gCSIT04kcKnMe8AP1COlOLwVQA3qOj0xRxggJnZgd6ioMTjy81?=
 =?us-ascii?Q?pd0oB8EUXvJuVPRcS3sgtFhjikk+eE+O89elUlqCcF8BEK/Wb4nm2+jgVoh/?=
 =?us-ascii?Q?SWDHDDVsU7kIsrfPj9TR9NUejP2ZjoSQiYk98w9mvMkEVfKdFdMJuwVNXGlL?=
 =?us-ascii?Q?jDyoxZihiDJekmPsxMENJuVeMl4F12J+PwzzMeWMvzE8rq8lQkIE/7Qvqkvf?=
 =?us-ascii?Q?+mBnf2PJHtCHpXKgFjNotovRSiNhJSNMJBSOhPtH87jJ0HuQ1T3D5rfm1LaA?=
 =?us-ascii?Q?MXdU32pti5U5t/04AyNcUzzNE0jM4ARPrTaUlaK1XOP0tdbElSMMMfDg1qxw?=
 =?us-ascii?Q?5F1xVXbchV2dL3ET/mHho8nKCPvu64UcqIDkco2BOMjI+D70Vk6pOffJsPus?=
 =?us-ascii?Q?/wCm2tV+k5bjMs4wEx6KkDb8/Yn7JwkZVtNTI2Wq9e7rmndGCT+gxXXz6nJw?=
 =?us-ascii?Q?mgknCoGM/vdy5a+EqA1qZG4th8bDruPgdntjsJ7lH2cSM10OTIgn7HhSXttl?=
 =?us-ascii?Q?JLd9IBxtlhnF1WdyIYyMKdhQZ4c1XYF3jUjE1QRubhkfNhuZjwAQjtgdSdHO?=
 =?us-ascii?Q?G4njN2mCIOmaG72XUD+ZlQTo9Ln+NmyS9hxTw23fxyvGPCCzFT1p2F+M9w9d?=
 =?us-ascii?Q?wUrn6HVorQlEpEddD84rdDsMQ/YjPMobhyIg/IgvmAqYTDCQa9w32eaOI6MJ?=
 =?us-ascii?Q?oIPCVi25YrE34KmhZq+bWQc7zWmmT71F6jCjIMOzTDbEDcvS3uSsOWlp/j8Y?=
 =?us-ascii?Q?ZqsSZsQeh42S0xKdaNc1RKLQGpfuqLH4rMzG5gN+OgR2y9/JgRjEP4vu0XWW?=
 =?us-ascii?Q?OfbCujTe1m4bGvIMQBF3bbizAdlV7U+AukDoQfMbhXam2jf4wmG6XmhLJXut?=
 =?us-ascii?Q?1Yr0g9ScFJzGPEVXoiIw7Ef2YQ78TO96c8rct4qaXUz1bOaQruh1R0kb3np4?=
 =?us-ascii?Q?mVY8sNLX8DhGssofc+xAvrnCy0j62NXzVyvHotlSdDfoHkyFuIRe?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 78bc39fe-9c73-4f24-61bc-08de4dff4b0d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 15:13:20.4816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCJgdi+E+L2Xpt9sWYrSZD2wSBhmGdDlo7F9jG2xMRKCX+coeKmXNAyV9N/WHwsJmVfrmMJPMbZ/VckB21Et7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2618

On Wed, Jan 07, 2026 at 06:09:38AM +0900, Dave Jiang wrote:
> 
> 
> On 12/17/25 8:16 AM, Koichiro Den wrote:
> > Add a description of the ntb_transport backend architecture and the new
> > remote eDMA backed mode introduced by CONFIG_NTB_TRANSPORT_EDMA and the
> > use_remote_edma module parameter.
> > 
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  Documentation/driver-api/ntb.rst | 58 ++++++++++++++++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> > 
> > diff --git a/Documentation/driver-api/ntb.rst b/Documentation/driver-api/ntb.rst
> > index a49c41383779..eb7b889d17c4 100644
> > --- a/Documentation/driver-api/ntb.rst
> > +++ b/Documentation/driver-api/ntb.rst
> > @@ -132,6 +132,64 @@ Transport queue pair.  Network data is copied between socket buffers and the
> >  Transport queue pair buffer.  The Transport client may be used for other things
> >  besides Netdev, however no other applications have yet been written.
> >  
> > +Transport backends
> > +~~~~~~~~~~~~~~~~~~
> > +
> > +The ``ntb_transport`` core driver implements a generic "queue pair"
> > +abstraction on top of the memory windows exported by the NTB hardware. Each
> > +queue pair has a TX and an RX ring and is used by client drivers such as
> > +``ntb_netdev`` to exchange variable sized payloads with the peer.
> > +
> > +There are currently two ways for ``ntb_transport`` to move payload data
> > +between the local system memory and the peer:
> > +
> > +* The default backend copies data between the caller buffers and the TX/RX
> > +  rings in the memory windows using ``memcpy()`` on the local CPU or, when
> > +  the ``use_dma`` module parameter is set, a local DMA engine via the
> > +  standard dmaengine ``DMA_MEMCPY`` interface.
> > +
> > +* When ``CONFIG_NTB_TRANSPORT_EDMA`` is enabled in the kernel configuration
> > +  and the ``use_remote_edma`` module parameter is set at run time, a second
> > +  backend uses a DesignWare eDMA engine that resides on the endpoint side
> 
> I would say "embedded DMA device" instead of a specific DesignWare eDMA engine to keep the transport generic. But provide a reference or link to DesignWare eDMA engine as reference.

That makes sense. I will switch the wording.

> 
> > +  of the NTB. In this mode the endpoint driver exposes a dedicated peer
> > +  memory window that contains the eDMA register block together with a small
> > +  control structure and per-channel linked-list rings only for read
> > +  channels. The host ioremaps this window and configures a dmaengine
> > +  device. The endpoint uses its local eDMA write channels for its TX
> > +  transfer, while the host side uses the remote eDMA read channels for its
> > +  TX transfer.
> 
> Can you provide some more text on the data flow from one host to the other for eDMA vs via host based DMA in the current transport? i.e. currently for a transmit, user data gets copied into an skbuff by the network stack, and then the local host copies it into the ring buffer on the remote host via DMA write (or CPU). And the remote host then copies out of the ring buffer entry to a kernel skbuff and back to user space on the receiver side. How does it now work with eDMA? Also can the mechanism used by eDMA be achieved with a host DMA setup or is the eDMA mechanism specifically tied to the DW hardware design? Would be nice to move the ASCII data flow diagram in the cover to documentation so we don't lose that.

I'll add more text (and the ASCII data-flow diagram).

Thanks,
Koichiro

> 
> DJ
> 
> > +
> > +The ``ntb_transport`` core routes queue pair operations (enqueue,
> > +completion polling, link bring-up/teardown etc.) through a small
> > +backend-ops structure so that both implementations can coexist in the same
> > +module without affecting the public queue pair API used by clients. From a
> > +client driver's point of view (for example ``ntb_netdev``) the queue pair
> > +interface is the same regardless of which backend is active.
> > +
> > +When ``use_remote_edma`` is not enabled, ``ntb_transport`` behaves as in
> > +previous kernels before the optional ``use_remote_edma`` parameter was
> > +introduced, and continues to use the shared-memory backend. Existing
> > +configurations that do not select the eDMA backend therefore see no
> > +behavioural change.
> > +
> > +In the remote eDMA mode host-to-endpoint notifications are delivered via a
> > +dedicated DMA read channel located at the endpoint. In both the default
> > +backend mode and the remote eDMA mode, endpoint-to-host notifications are
> > +backed by native MSI support on DW EPC, even when ``use_msi=0``.  Because
> > +of this, the ``use_msi`` module parameter has no effect when
> > +``use_remote_edma=1`` on the host.
> > +
> > +At a high level, enabling the remote eDMA transport backend requires:
> > +
> > +* building the kernel with ``CONFIG_NTB_TRANSPORT`` and
> > +  ``CONFIG_NTB_TRANSPORT_EDMA`` enabled,
> > +* configuring the NTB endpoint so that it exposes a memory window containing
> > +  the eDMA register block, descriptor rings and control structure expected by
> > +  the helper driver, and
> > +* loading ``ntb_transport`` on the host with ``use_remote_edma=1`` so that
> > +  the eDMA-backed backend is selected instead of the default shared-memory
> > +  backend.
> > +
> >  NTB Ping Pong Test Client (ntb\_pingpong)
> >  -----------------------------------------
> >  
> 

