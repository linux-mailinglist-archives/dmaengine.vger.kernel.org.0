Return-Path: <dmaengine+bounces-9114-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KBiK+Btn2mZbwQAu9opvQ
	(envelope-from <dmaengine+bounces-9114-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:47:12 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EFF19DFC9
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB5B9315EEC9
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 21:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D7F318EDE;
	Wed, 25 Feb 2026 21:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OF/5kqA7"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013067.outbound.protection.outlook.com [40.107.162.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B163D318139;
	Wed, 25 Feb 2026 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055750; cv=fail; b=DstknfObQQSS7Cfu4t6R1SsVRrTPPRCAk31DfVESJ/Sb7Bix1r5ZBSN2hHaHCCv2vwZZ8unzVHPtXRNix8/cMVfBwohVJYjNptJt5ZdmilJL7r4mc5YdbJSAq6OzqoixuhAeqHX0Hkrb72buTECOv3yR6JCoQI0aY4eF1TgL7Wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055750; c=relaxed/simple;
	bh=LqmBiUUfJ3D/6sJKAew3Rg6UYWssz2TCXAuHkQ+uJt4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qMibiM97YpwnBAmoLhb+o10MmnxyHr1JSTswHYNwdvDkIF8uECl/lyHedP+pf3gZHahiQDZbUkjIftzDG+bMoMMSVh6V0HkEg+zYeWg+9/39HqjOOIMquFZPCyyOrVl7Y528bWBhOscXHBp9QhdGY+hxNXRb3GFXIQqfGDBdPcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OF/5kqA7; arc=fail smtp.client-ip=40.107.162.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NM0GYOa7/D6ibfo9jukoeD68/Ydg2rHRMC/GJ0EZT7Ta20UX7pHjHdoo7vX8kABf0tGsFGtxbzwf7oZAVVVqHiiXqZrx23thmrzWpXKRBY/2aNemNk2+xJRWe9F2Bw0DY9JURqOMZ87N5G0LNyB98u2oHGpez9eugk7m7SPeYLyW+re4l938DKBJdQJOgxcjM8L+Y3h7lECoYbMi7RdFy8LrkPxs3NUNR35NltUjXX5eb80FCBoLz+iZY+b7W5VEOxPE7AtAlIPNQ0XFH8b1UGbhziM2JhGJAwCVcEyZuhywzBLFjMCk6RJvdAmAeYhkimw4sIxzi+29BJtBsoW9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibm9G7oS0eJbxnVBjo19RjaqCD4zHPYW7izU8l9+oVA=;
 b=HZtO4JkbGF3ryxmePjGYD6hy4XyryEdWlQ1WrbhmztohETAxNJoPj7Iw1k0OQkVsDRv058ObwBT4H+lBdH1h3vltIRfSltG6JXRqvkVXkcj4Prs29vf8ulQJZR73cEY2dgijhUaddwzDnT+o76/2HxtSNQmk1j3YG9RZHuxy92jw6rpos9Wo7t5Tld3LdVSE00tucUgZZr9Okmc/QNbPg4t9mX1s4TFosvQyK4zbgQW8iDmIRW21P99Uo+ZjfIoIErhpvdWHHGqbeoyLP0xzB9FerViTENlOc2Kt4Wcdaxf0NNz93kiViixCt7pjfcNoSXKhv+Yqnga9UAMUgUbKqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibm9G7oS0eJbxnVBjo19RjaqCD4zHPYW7izU8l9+oVA=;
 b=OF/5kqA7pSkq/TYjPeWh+czTSOnwK3e3dcNq/Yva+5FK2ZkRJLkjeW6C9YuBj9LMoMdREmz2Gj7AfNuUugXUeRwMhWGswsWF7LzhQEvdudAGh1uuGVXPgsrBuzkuZT+wF3SlsxLcjcSVuEarbiOGYJEpgFqFZSC1wj5dZjcFhsMAGxOMvnsIeZE2whxv4Rf80A66OyFH1/tIh0oQ0YIZhi+NvXcug9OPXudN3s3M8Yw8sh51T0UpuqJIMI/2aXS75AktFyRiMXG+KtnAm8tvmL7B7qGHBFpiZ0rY2+8lFO9pQ6bBGuO4pvvlxAzHKgEHQl6I035Knp/un72/hFE3Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM8PR04MB7346.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 21:42:26 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 21:42:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 25 Feb 2026 16:41:46 -0500
Subject: [PATCH v3 10/13] dmaengine: imx-sdma: Use dev_err_probe() to
 simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-mxsdma-module-v3-10-8f798b13baa6@nxp.com>
References: <20260225-mxsdma-module-v3-0-8f798b13baa6@nxp.com>
In-Reply-To: <20260225-mxsdma-module-v3-0-8f798b13baa6@nxp.com>
To: Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Saravana Kannan <saravanak@kernel.org>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772055708; l=1223;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=LqmBiUUfJ3D/6sJKAew3Rg6UYWssz2TCXAuHkQ+uJt4=;
 b=TnSw8sxbgQyuH8TexeBAt4EeXqy/nYP8S5vbRP+K2WZFHBnQcufwn56kdqf76aVhVKraAaZjv
 m5TyLc915CEB8mnI7u4ClgEpQe8Y5tuOLt2GyCq4MCGq1ROz213xe6r
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH0PR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:510:e::27) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM8PR04MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c348467-9e2f-4fef-8349-08de74b6c43c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	/zc86V+PyKumTxIq+2F46q3juMGV7FrL0+YATI3mDC1yrqUxF1NCiCTBSwDJbzgzIRiWSgsFuAOc8gl1RRDsRqWkPr1635TJ3KlE+P/G+zjGsHL5WMMcQLyx9+5ghckkxtPuJfP+d6XUs3N2Ec1FKLW63TVCLhIHnKeXC3gaxYnu/BTaxYA3tLRbZYzu7QeuQmNVr2/dCy5DZZidgyJ2WIbrMqgMmRYe2OOOAraL9Z3yOw4siBIYt2EhsXbjn0G5/SB+u2EnRQYf0pObn4878b5N/AyOxkGOwY2v2tpdYDJF714kF9m+nOIGJRt/dwcrihlH1GAXVIcwQgYkpXDdvYtIRkinEpRvm28NUdj4OTdak1JRZ6OVOMAB2qVRvhpo0lqmhE65ZeSzEDcYIOyWeo2Ut0AOYiNGl2vhHLiXSElbZ3QsWr8V5H9OGHyrwCkqeOb6bikI4elmWsdOw8UVL/i0RZ7sCvKxcWkdFccva0jg06WjToMROl08cmY49rZesE35c1Ym7D9kla/ooCPzetHqorxzJiBKORP3YRoq/6pnWg3eEqYjPYIq2HHcB43QZBy7nvasLLBF+wI40DIZWAqPyqrfE/4HCf03eP5k5PkIRwkJyEAODmtTbVJRioFXGI7xYnkqrAN8x2LKMwn1kkOnO82YicuXCcZZxA0e/mXS5H6m2MnR6HpdV6RzgMq2+9iXs+41SnhhAe4f+G7qUY83Ksr/3CH2Ffoi9UQzmwlcenQXjZikjMLWF6l4+FNJoiZ5Ntf8aSadRWaIcxunjMfYnkgp1jhazuBE//949/I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0VDMTB1ZCtGb0UySmcxRFhjRWp2WXA0ZG9FZ3NNZGhSMWxCeEI5V2FkRklq?=
 =?utf-8?B?YjRlMHVLWWdueVBKQzdpZVcwS2hObCtaYmlvTWE4QlBJYkhwMlE0eC9GRjJy?=
 =?utf-8?B?V2kza0s2SWU3bzRUYmtzZVEvNWh6MXVCYWxvN3cwU1lsOTJEd2N4YjZmRUll?=
 =?utf-8?B?Mk1kTlBqOWVrTS94amZQWmFNcThRNDBlejk5dm1YY3VLUGkxVkNMaUZobjBj?=
 =?utf-8?B?TENNcXdsbk41bFhwT0xxeFZ6RkhVTW02c0Jxa0pxKytacnl5cE5oSVhjQjM1?=
 =?utf-8?B?eVRzQjJpQmJGSDRWUVZxZUFoczRCN0pUZlVTSmVJV1h3aklzbjRBYUJLaWpy?=
 =?utf-8?B?bGw4d05lQUF0WGdmVmhSUllUdWhNMGd1VGpTVElXMGxuZG9pNXBsWXJtMVZL?=
 =?utf-8?B?bHF3dGdURjRLbmdDMkk0NDVqUVpuVTA0TzBVVXdObnAzdXlwd252VUt5dS9Q?=
 =?utf-8?B?TC9zQ1lhb3BCZVdJaEJxRHBWT2JOUUorWXBhTi9VcXlzemZWSlVraGFxdW81?=
 =?utf-8?B?TTBkRWdVMkxWU1hlOTdQaWVOYVd0VEQ5d2pBWVdWcHIxVitMZUUrMk9ad0o5?=
 =?utf-8?B?N245R2ZKRXdOREpGUnByWDNnV0U3cG53MzRYMWt1L0tOc3BWQ0FHVGUzZXVn?=
 =?utf-8?B?TFZmaEFZb3J5bmZ6eVVYTVhrTWJHSWgzaGdtTXUrSHFRbXQ2QTVxL2c3N3pZ?=
 =?utf-8?B?Qmo4b2lpWWlGNHp6c1ErTjhYeWliVnIrN1k4L0FielEySEh6RTlSUlNjMkN2?=
 =?utf-8?B?WjFweDllUG50VmtwTWN5cmhTUWJBSTVWUUFPSEZjRjZJNTY1UkdHZjVjRWtE?=
 =?utf-8?B?YlJBNmh6SExuY2I2Wk03TVg5YmdJdCtZYk1hMnd1MDdaRkZxa2I0Y2M5QVNk?=
 =?utf-8?B?YXVIMFhFazFnY3MzWnVvME8xRHpwaHhUdktZanErenpyRjBoWXRVZmsyNVRJ?=
 =?utf-8?B?ZDh1ZVR0YmRQU3FhdGRhQ2JLSE9mWng0L1FSV3gwMndNTlpoMGFhcVNyVnM3?=
 =?utf-8?B?bjlkMStQVkRtKzZMZGxqeWdKYXdVVDZTUUFsVUhJVVRicTY4SHRGNTJWa3ox?=
 =?utf-8?B?UkhQL2Z1QW5jQW91OW9VejFUTkI1bktTZFdjNFRHa2hJWTF5MTNGZ1ZEaVFF?=
 =?utf-8?B?NFNjTEhWb2JMRHhxQzh2akVnbWdVSEZmWC94UlRLOE8vb2xoSGZlbWRoSTYv?=
 =?utf-8?B?M1VnWEdEY3REVytDNEptNzBTVmlTc3BWdVgxOFV0b2lEMU1rUlhXYmJlc1Av?=
 =?utf-8?B?WndURlBjaFZMZ0RxcVRNWFNoUHlvcUFFOEZ1SXVlWC9oeDNzb3ZaUXQ2V21N?=
 =?utf-8?B?cnFMNkNUTlEzN2Z1MWY0UjBEOFFjSjA4TTBYeW0zM1hReE1NK04xemxMMHBh?=
 =?utf-8?B?d2JuMVFvVkVib2Y2Q0lydE9UTm1JL2w2S0I0cXdja0l2VlphWmNYK1JzSmpu?=
 =?utf-8?B?a2RMclh1aFg0elVVSnV2ZjhCa2ZTOFZPZlpDV25xUGJTOFdONDBXV2RHdVhD?=
 =?utf-8?B?ZDJLYUtnMi9KZ20wckpKM1phRzc1UVAxY21WS3NmWmgzMVdEUXB0Z2gybGRx?=
 =?utf-8?B?RHVZZ2puTmp1QmtoVFJUbGRRRStVd0NZOEJ5L1JjeTBtcGJIUi9TamhFYkMx?=
 =?utf-8?B?akd0QnpuQW5RQWpYTzhBaGNqNWQ0b040aklieXVXRDA3bXk4OFM3a1IzS2NP?=
 =?utf-8?B?QkdiQSs4RlRvT1NqMk9XU2doSTNzR3Zpa2VHckdrSi96bmU2SVVaUUVPRnRm?=
 =?utf-8?B?Zko5ckhnWTBQK2x4clppWml3UDBmU0ZtNElFQ0VBbFYwMFRTNDBlMTdKa0Ri?=
 =?utf-8?B?bFpLbjZVUElJSDFqaUxxN2d4UTUxTHpqbGtSNnlGajFHVjBGbEU0QlZoQVVh?=
 =?utf-8?B?Wk5YZDFTUUdiMUwzckNWU3Arb3p2dXg2WUpPRFVkS2o5VHQxT0Y1Nks0dDJu?=
 =?utf-8?B?ejA3M08zQnJSbS9PREE5T2h2bXVSYWhlNVp4blRvTCtSejQyVEU2ZFZvanFv?=
 =?utf-8?B?NFJKdE5odm1FeEFvcWRaRldZNkVYc3FNeUMyWXo5cS9scENYa1ViUmtQdU9z?=
 =?utf-8?B?ODIxTU01eWEzbExLSElrT2RpSGYvL3RDak9PcjdvWWtnRUNmaHV5TnczYUtZ?=
 =?utf-8?B?R0N2MXU1ZzZUMG1IVWh4S0R3N25SN21IVGNFYVNwRjhZL1dJcFA5RkhLV3hT?=
 =?utf-8?B?WVhRYXJXa1QwOGRWSkVrUERjQllDT2FLYldyTVJHRDZPNUttZUxMVTJzSjl4?=
 =?utf-8?B?czRXcWo5M3h5QkpTbEJXeGRzckFycE50L2xGU29icXNWWnBwVEREUzBoU29M?=
 =?utf-8?B?cWZkTFFvRGR4Mi9HSGlVSmY0cGg3Ri9DS2I4ODM4Y0lETVlEMnBnUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c348467-9e2f-4fef-8349-08de74b6c43c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 21:42:25.9755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQuR5ScqeoSDWDwfYN8iQ1eaflo6qageqBopoYFThneGYmt3PANLYIaQkdsuubmdWfBahrPttHiMQAwWQ1yZoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7346
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-9114-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,pengutronix.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:mid,nxp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 58EFF19DFC9
X-Rspamd-Action: no action

Use dev_err_probe() to simplify code. No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/imx-sdma.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 16b5f60bc748ad20380670da337846fdefb5fc58..3d527883776b40131c5c5190d12ef81c9ece8699 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2354,18 +2354,15 @@ static int sdma_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, sdma);
 
 	ret = dmaenginem_async_device_register(&sdma->dma_device);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to register\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "unable to register\n");
 
 	if (np) {
 		ret = devm_of_dma_controller_register(&pdev->dev, np,
 						      sdma_xlate, sdma);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to register controller\n");
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "failed to register controller\n");
 
 		spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
 		ret = of_address_to_resource(spba_bus, 0, &spba_res);

-- 
2.43.0


