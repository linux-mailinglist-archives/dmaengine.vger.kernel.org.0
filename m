Return-Path: <dmaengine+bounces-11627-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 97RBIPZDNGpmTQYAu9opvQ
	(envelope-from <dmaengine+bounces-11627-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 21:16:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C750C6A2517
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 21:16:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=uYscytR8;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11627-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11627-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89116301AB93
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 19:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6082D94AB;
	Thu, 18 Jun 2026 19:16:03 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011023.outbound.protection.outlook.com [52.101.70.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4633A24E4A1;
	Thu, 18 Jun 2026 19:16:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781810163; cv=fail; b=YAvkMZiF7mX5kqS9Qe4RNE96hyh7KcgXYYcT8wqa5NQmTF2W/rnOMj/enOkgCqK8tHFmdB2S1zOTOmj/1/pfjAdrGgdkcjQ4p+qzzOa3mCU9Ql4fC39jW54TH6ihtbdf4KMqVQXRhlrFrObvEeST/dJiTyBA5K4qr/q3IgdYT0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781810163; c=relaxed/simple;
	bh=tkQVplKzcR3VXgGWdhZcatXeBb/Qs2Q4Z1I4zxCMv9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p6S2VOm4XHPyOAhUgfMn56P0b3UgYntPqsKQoNeqfn9VUXAHhBG8z3+mwX9Bc441dcHFTybKXut2zzmJHm1XT/n4lFRqS4exEN/gKFDtyPS1WpY88HQMwQtTkjLtRrIrt4x4talIsy3IyFFxkcwGzt3mflItRmBZ6uOksHDVSE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uYscytR8; arc=fail smtp.client-ip=52.101.70.23
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scG7daZVrFt7HA5YESQAWIT5LwXh8n9j67eFLgacoMkt/X5f/Og+fVmgPO3FsB0sRFoXNCVVqAmEK5YTYIZxx1m+feYtNbtb2Ez2Dndb5XVR7rtBEqCOftBqkrejePudzcICL+4X0DkbDyshcdzqVAvakeZcTC05RbLt+mRNzDqG/4O9uDz/C8hf7yNAExUi8OwusuoV/EWC3jI0/+1eHQOt9k98iqumxmUKKHhPbLlHy4CNDIyJAz8a4Vx3g4H9AYlBY4TmzeTUCSuwcAnOQplvHP1TgocwPKKPBdBHoBjQm8qgG61+MIcL8+sgqmS7EYka8XWky6u7gqnnrt1BUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AFiCKxCRI+YE87/bTWaCD8QqrDiIqN9rCk7Q1U8HYs=;
 b=KqmsyXC+3HMX24chZqFKQNeMO9XW/gBt5qBTvaM7KM6XIAY+6uMSx4T5M9ON+QGCMRE9f+reEyy//NpIjiHvsIuDFM58YAmAo/Ft25YgbotQ+V8v3N1RU5mL/bmAI5UKbZyyikSkoy7qEWqzAHrVqAsIuAUBcChFs04AkktMrcMTW+p/Pmr80CFBB4NnKRS6eh+jIJ8HCBkCDacRwCpjYXalpFMd+o/bgxEuviLusJljNU2aZCo+QBl8b5U65S4JItV4TCKLVEedbW7yfHVqtnHDJVOZKRsBfx9TXWtO0de0Zid873ybGY23ECXahVPYJlPS55fO0wMlyO8fc5+kcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AFiCKxCRI+YE87/bTWaCD8QqrDiIqN9rCk7Q1U8HYs=;
 b=uYscytR8/XiUSh253gh7xpKZRvO4jL0s9p7azw2A07EAABkKl56cRMtAHsEp/sYybRf5SVYzEj60CKVU9AmZPwPDSX9MmlMmDLPp6EXLMPZ+as2kP0dlhPM0tLYhg2wv1ZBQtF2tGmwBK0oemTQMvy1yBnuTATHrx709Y4hZ903YgPR727lI85Og2rmglP9PXTizTXlz2POM6Hgj3aZWWe2eG7E1HeHRKYh6yKAfrNSCuJ1YqAwBhou4UwRGYqLJ1cZLPDCfRVvbYdnZKdiZmVZOnKLAgp5TPCb8JCskvHyboUPkMtuqiwov1kGSUvg6vnJbPaW22EoNf8IMV/CKXQ==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PR3PR04MB7372.eurprd04.prod.outlook.com (2603:10a6:102:80::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 19:15:58 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 19:15:57 +0000
Date: Thu, 18 Jun 2026 14:15:45 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Golla Nagendra <nagendra.golla@amd.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, michal.simek@amd.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jay.buddhabhatti@amd.com, harini.katakam@amd.com,
	m.tretter@pengutronix.de, radhey.shyam.pandey@amd.com,
	abin.joseph@amd.com, kees@kernel.org, sakari.ailus@linux.intel.com,
	git@amd.com, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/3] dmaengine: zynqmp_dma: Guard IRQ handler against
 spurious interrupts
Message-ID: <ajRD4VyUiU83YPdJ@SMW015318>
References: <20260618071056.2024286-1-nagendra.golla@amd.com>
 <20260618071056.2024286-4-nagendra.golla@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618071056.2024286-4-nagendra.golla@amd.com>
X-ClientProxiedBy: PH8P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PR3PR04MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 278edd87-0ccb-4252-3ba8-08decd6e06a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|19092799006|56012099006|11063799006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	4bbCAwxJgX8kBrPGLikZ1DWDgvb/De5mbgWsAr2KwoCBv78DPhM7Rc8AZQj8nyLc8YjBjnCluLJhcvV+/maFQSIIkNPj3fWOgE0ITZneo/377LY61+8ROk2gCi3SRhJKy0GfLR9DjGBzt2T94fppkn+O8A0EfDY59vlkO0E4VzFC1eG2dUUzd4EIqgOnd6nhsVSuhW9vk7vvW5jK7EroTkqeBsPJfya4KD3Vj6ok/EQoDFZVDRBm0hw4A2db02PwDmn0w1OJJ3dCuE7olSlXhq8MBs2sZm76mKXGIiTgTjSlZ+jEj5ye7cYBk0UoCGq4mGIAUCeUWkOZa75lMW9Ld6+QJ9XSG5TLhjTYZD0KqMQ5qxUgF4ADIelYjiIq9j+5lzhp58+BfhkF5KcsnrJIAlxUmOjP7S0I6Ui7qSsWbcSQ0kO9aEOXzh+GmRmyT62f9kN3Nv4EsqLP18ptsftFfms31n6pOxSntVEm2Qmw0AxWbbphvwpfVB/k8OMXux1APUac2ZNqfDb2uTRZ3PdMMCbGpmcSoiigEdWYJuVJ9YakkJahLTHzQj+M0XUUzJHsPkN2dGSXvARiYkxxoh0ni2g4SDQSNGjcaco35sAdTuh7jmyngmsf+bvtSFy/axNUBTXeNDHhpNRVhnZJXTozVS4mqWsbMhnEPQUmWWAYw2/Y53jDIplEngc+rOivzXFj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(19092799006)(56012099006)(11063799006)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g5E+UfgskJIkHzh/gHyhT9751xTTcf5J7lHJH9fdyjSnNDP6LrfzO4z6C3jt?=
 =?us-ascii?Q?IWaZ/z37gh8KnhNigfZ9qYExXVzV246Ckb9g+cc6xsSO4FwZD5ah/zMUzbgZ?=
 =?us-ascii?Q?z43T+D4TElbD1196ZVJyw31VeqPLbMq+8ipFsoWJDMiV1bWjTGP3zAZs1LQv?=
 =?us-ascii?Q?HWWz1YPqggogXAQSt7KIU+6Bmu+sPZphkeFnvAbX5OeqkfFtLHSOo6tRZnXB?=
 =?us-ascii?Q?XGHalGcGIVb76sHrmytxaJs6mvxMOfjJFhAddwTwtwTXQkq2RELnDWZHPU0n?=
 =?us-ascii?Q?NswK58PIaU4ZDpAvpQthbByWWoG34t2BfDqWZTamZBi+GdPEyclIpGzwQJub?=
 =?us-ascii?Q?2SnBB+9AXENenJnKjcGGKbSSoYP5UACymCW1pfHbALpmt1i24THa60aZj8Vz?=
 =?us-ascii?Q?bvDLNzhsWh53atPciuuhFzlKJxtKPtCUD72CvYHzqCzakfVbzeOXVrw54lMt?=
 =?us-ascii?Q?PKXFMpiJYJ/AwtcaXjIAjAHEHEb+/x1KfIT7tW1u2IdNWD+Dj9UtxmcTHbsO?=
 =?us-ascii?Q?J6FgPllSBXg7SJAV+DIuS9REBb99qbheQ5V4tRlImX/AcVks0rT3RTeJUZ9g?=
 =?us-ascii?Q?uhMC1rCFnuh8r1QB+szjzlMqjY0cHGxj2F2ymmz2BY7QZZW/BGnVm5u26tlv?=
 =?us-ascii?Q?xrEf1jsI2tCcFYrpAZ+brH9HWFiEEfF9oyFBgFox12bPhP2dCP3VzruFk6k2?=
 =?us-ascii?Q?dDu15NpUfMn4KKZvy5VprqDPjpdLXd6HPVA4LpXf2bqliVKBxPYIPawaxQup?=
 =?us-ascii?Q?DgpEC1rwoJYVSGgPgds/mzcZbebfzDg494w9GC0FrHZj5gtbUKJPBCI3ywzI?=
 =?us-ascii?Q?Uss0KK5iB6xj3H0LGBFrKO0Xbx/0ezcvZ0u85Y44THeT0/i9KpnoN6HFjiVq?=
 =?us-ascii?Q?uyRSRIf6rA6QivvzeH+OxTiTKG3SpgLDZogUmOyD4WdOLIXjiHpKoTf04NGt?=
 =?us-ascii?Q?KsHZlH+oWEZ8bJdBVb0ea47+pMBzOVXwp1OZy8bx/AVmxeJdIWvcllrIoVqI?=
 =?us-ascii?Q?J4xpNG0sxtCYSpey4cSGpypxJi+TH61C9h+qc94koA3NARwd17Ati3bEtKN3?=
 =?us-ascii?Q?QLpoh9e1sp1ytYHHG9rsZuKAAmfcxN6f+O8W2HX5kRo+f6OWyabE6gkbM574?=
 =?us-ascii?Q?hAoHWxCm9QpcYXByOyLYsDoyQh2dJVkVAE8zg414n+tAE4GH2ic9jngeuuvO?=
 =?us-ascii?Q?gyGOZhlBibqj2NPgYDEBdjKTBZmzx0MFK0W36G72kVh+LiMWrP+soZp868bZ?=
 =?us-ascii?Q?dw/khR/vFO2RbO0AiVJWaip21irFTlhpogTx5qXUqL+NgzToKvq06mR+lVjc?=
 =?us-ascii?Q?FQkwXHb0IUtR8r1W6MBFs3/0qTacD62EWOWfdl9GobR1j58Vxp5MRRJaec1k?=
 =?us-ascii?Q?8ldH7uOaLa0dm1KiZOjPS8F4fhpVWUkPNiFawXImE6eqPadfB/nGzD87S06l?=
 =?us-ascii?Q?cATPEIn6eb0x67kh0TalNMY9dzbw1u/DzBp2QEMo3YwPmRtaSige2CeaL9lF?=
 =?us-ascii?Q?kLTAxzSG7LlSnycN6y8n53gcvfjLv1G65FrNooaSBhor1m3na+F+svOGOgvD?=
 =?us-ascii?Q?RrqtkMAy8oyJH7QpZHcE0WeaXBIfvQ1QVzMMGNYGXyxVMv9e88walBu3ZrCr?=
 =?us-ascii?Q?Rt7r/lM+cPaLwFJFLoFBGASk39SBspIFTDlMZjSTLW3HgO3Pc4cjpd0Wsi/l?=
 =?us-ascii?Q?4WULp6I7AHL2fkGiwgBrVnrecK6EBDkoat7OMFem2i1TFw95L51sXMz2UzPQ?=
 =?us-ascii?Q?sX0jwWog6Zn0bwFH6w2vDe/62A/u73bD39eGHNJan+lvzMDGvfCu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 278edd87-0ccb-4252-3ba8-08decd6e06a4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 19:15:57.8140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: raGxWMi+gM8b4eVlukZRBSLH44rtRU+Ie8Oa6Hu6a2shCPNyjhjfG4SSulE+yNGlc66qn0YzUEu2disZF1UIhrqgPvNPIOlGKQvYI2UXsaOxda2PD1WPMFX55KVKfNKC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7372
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11627-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nagendra.golla@amd.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:jay.buddhabhatti@amd.com,m:harini.katakam@amd.com,m:m.tretter@pengutronix.de,m:radhey.shyam.pandey@amd.com,m:abin.joseph@amd.com,m:kees@kernel.org,m:sakari.ailus@linux.intel.com,m:git@amd.com,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aka.ms:url,amd.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.nxp.com:from_mime,NXP1.onmicrosoft.com:dkim,SMW015318:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C750C6A2517

On Thu, Jun 18, 2026 at 12:40:56PM +0530, Golla Nagendra wrote:
> [You don't often get email from nagendra.golla@amd.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Add pm_runtime_get_if_active() check in zynqmp_dma_irq_handler() to
> safely handle spurious interrupts that may arrive while the device is
> runtime-suspended. Without this guard, a spurious interrupt could cause
> the handler to access hardware registers (ISR, IMR) with clocks gated,
> potentially leading to a synchronous external abort and kernel crash.
>
> When the device is not runtime-active, pm_runtime_get_if_active()
> returns false without incrementing the usage counter, and the handler
> returns IRQ_NONE immediately. When the device is active, it increments
> the usage counter to prevent a concurrent runtime suspend during
> register access, and pm_runtime_put() releases the reference afterward.
>
> Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
> ---
>  drivers/dma/xilinx/zynqmp_dma.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> index a9dfec3c0ca3..ce9163138be7 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -730,6 +730,9 @@ static irqreturn_t zynqmp_dma_irq_handler(int irq, void *data)
>         u32 isr, imr, status;
>         irqreturn_t ret = IRQ_NONE;
>
> +       if (pm_runtime_get_if_active(chan->dev) <= 0)
> +               return IRQ_NONE;
> +

Can you add AQUIRE macro in include/linux/pm_runtime.h
so here can use PM_RUNTIME_ACQUIRE_IF_ACITVE

Other person can get benefit for auto clean up especially if there are some
difference return path.

Frank

>         isr = readl(chan->regs + ZYNQMP_DMA_ISR);
>         imr = readl(chan->regs + ZYNQMP_DMA_IMR);
>         status = isr & ~imr;
> @@ -756,6 +759,8 @@ static irqreturn_t zynqmp_dma_irq_handler(int irq, void *data)
>                 ret = IRQ_HANDLED;
>         }
>
> +       pm_runtime_put(chan->dev);
> +
>         return ret;
>  }
>
> --
> 2.34.1
>

