Return-Path: <dmaengine+bounces-9115-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLKmMPVtn2mZbwQAu9opvQ
	(envelope-from <dmaengine+bounces-9115-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:47:33 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E39119DFE5
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18B673068ED6
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 21:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97064318B9E;
	Wed, 25 Feb 2026 21:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IUtn48LE"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013067.outbound.protection.outlook.com [40.107.162.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B591318EEB;
	Wed, 25 Feb 2026 21:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055752; cv=fail; b=doLoIiNcY7WkyfUb779aaThluKeJYfitl78NnDChYzysnvAoX4Z4c0DDiMPQRz3CRO4/VOss+x9q8cI5Y8kqX6y7LPWBxHPI/QAwxnkTSxiCDlJvUrzlvNifYWo/ecUxzQ03YNPPipKH1oLgYLd0oymZmkeFTHtsh63xDaGQ9g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055752; c=relaxed/simple;
	bh=LobZaK9oHMyCmCTQQ5Fd7Nu88yF4BPb0MAWljef6GBo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HzRgPLk/a28zGQRrwqqJDQHOIgp0JC230DEk9ZYLnXrxe/xHhHr21/pzGTCOl5+CEyZJ7YjUwCmnZfVnube96X1J5GfukdzUsjf4xjyuIKRuyaCDfndyYm7jdn9EY9DQx50pg7zkUL8JhpkGxuThIti6XtBQO8Ma4BTAvWocQPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IUtn48LE; arc=fail smtp.client-ip=40.107.162.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLi18JfGUxMZ/oTlQcjuXrmIY1+7zYjnQeHbxPZdxWdTMe5AMqhRmMpBYRVgSTJU8ue7X8pQXwBLMvTE6siFxHhuqZNMhBCdBXBPjSKxhF756cOTpdUQGI69wV8F1EGH84eA7Tm3DoigbT6kLSb4zl4Q3TwZtKzlodfdSDZeKoQoAtEb/CWI74grRE+CzGh/l22SkG7Io/RIdIK25R/KEfKcA+MCJ+cr4VnCxCEyNK/icRP5tn1wUC2cGB8xZ2aEtiiz0ufEILZxHARDbU9To7rgqlCSVEMDAQyXwBQoelfMVUEHFbZFUGp4fOwQQIqSewXk+pQDM7VCOrNTS2imFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVgOngjerv2EzM/ue4qMpX2Z12OZyUIaVsrj+Kf8wYQ=;
 b=fouevjl3noOm8PfpOkgfEBGdkyADLShebwj2nGozlKjopAfr0qd6MMmsfwJXa9CxJH7P30CKhGSKk+LEyx+uzHgGU/IMJ/h5eP0PghnY/u3Lfsn8WDSz+2P/vn3rKQ0+AC5H6O2WUsUJDJ4ao3/c6POdRZOqLdMJL4Kp6kAQ6L/LZRlKLtOPqaPv33nc+jKskr+EF8v4SAzoqzHK1ZlWMzVjZOjKd//IUEmOtm86wRI3FBxpGleWcwp7I6Jf1UureXTaEoBYLr8uXavcea7spwXucM5NCgAJxoS866AM4v47E5ErAQgv40n62Yhwns0ux5cgaWk0XIKwkVVuDi69Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVgOngjerv2EzM/ue4qMpX2Z12OZyUIaVsrj+Kf8wYQ=;
 b=IUtn48LEYfBA9L4VR9lciVb1I0Q5MhMhAvSRAkj6Lzp/nFYyssePICKGOBzzjl4L3tAVnSg3F8G+oZJgqZ/SRimPZXheNJ9XGbYV7qfWCbEePG/Ap1DCYSzq+7R7zv5Cw3mCsHlsqsGybaUzB7mgT3jQ/yWfpOBkgFRbF5t7QbwzYUJDtpQ1A9L6B+0fDs9ixBlMAj0z4FNutQ9VuSCQCj6LJN0gJ7fT0giHdpTCy56j3Too4c8NxG7ycacsdbYE9A83i5i7jMsGu99qPt55/4dYMBB/HAWl/LI0nLclj8vZZ+slzeoeKrFjJ/0+lDQFSd1tXJJ5g8R50vZuEGGXwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM8PR04MB7346.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 21:42:29 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 21:42:29 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 25 Feb 2026 16:41:47 -0500
Subject: [PATCH v3 11/13] dmaengine: fsl-edma: Use managed API
 dmaenginem_async_device_register()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-mxsdma-module-v3-11-8f798b13baa6@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772055708; l=1654;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=LobZaK9oHMyCmCTQQ5Fd7Nu88yF4BPb0MAWljef6GBo=;
 b=/QFFPLjx5QP6N8ymV0hSvaoVoabJfUxMJIqivHhwFh5ZmExKhimlXsEH5ptz8E0qfucDrGlhl
 sygXBjFuyBRBOr5T64Q6aIu1vPE59wfIPCHt3hTG7KremCmLU1tWT90
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
X-MS-Office365-Filtering-Correlation-Id: 68b8dce2-49cc-4e20-9361-08de74b6c635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	jyOJOuzV9/mah9FX7jYTd4iN+8V6yHf92Z/RIqnjdfs/uPdgAchOwKJn8mshZ6ZE8VBe18h9BNNvwLLHJUSZYnGd27prNnbSoG5cIpWabWArY5UH00O0W23J24mfACe9ZppaROeWa5X63ssWRUddzJeRfvWtR9Pqi8AkeSYit/uuNTPCbIgvo6Yeu7ZrM58RHAots4vdm8VmvJEVfmZ88hmpfz2RAEGdV0y9Ty95AFQTLpjtj69MF2dITbZbas2hDPgnf/AO30LVLOfqT/PpysvCc2gayL7XOmW+ayLCGGJZZ0nK2xov3KvBegbCB9nkLMpQxj9b/NyPHMR8yHmg5JBmAQJzJsa9x+UTYkb053mZozfh4naLQEUlXlzyG9poSmsZoXr3YZ/FPTDji8e2+dlm8BUCKSHXv4twCSLeeabI1ZvD2sRTuSvW98DAeHbi9Xi8hdV7/k3Mkvn4IV0jMSbzop0UZDtmUpgDZfefa1E09Wb4AMRaKAwK/SYIepABIULJbkgUwoxznun0rmmHojHZ6YDtvYmKqEOuJXvyEHaWZEplozb7fbzqZCE+6qu5zOg2IFdCcV2mFUwBo2Px/bj4rBAkO5V3iyDarxXz9wN+X4A8luCrPu2BY64DzeQi7OL3heTpfXJ8+4yAs9+Kktvakp63Q8Z6DRZOBCB6vkCeeYIK2CGN0FCNMiRVBg3RUwU1TBKC65GVRYuSq7J+nOeAMbDSTOsFaY+nauMOOWeMVUbgi88iZ1/XTWw/hNW2nLwdwN6WwbpFWw9uk7p4bEqwMCLlGzwslZe/OtjjwlQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkcwMFZ5Y2EvcGNDUDBVa1h5QWs2OEcxWGFGZ2xtWGpHYWR5UndTdjdxTi9D?=
 =?utf-8?B?T2lFSG1DUXNrK0lGN3JiNklHQTFseTlTalVFSW1ZbTAzWjRtbjhHVEkxYjV2?=
 =?utf-8?B?SUxpUDVCdFRiY21NTmtIVXB4VE1jUTY4VktYNDZrRTJsczFnWGdUVi9WVGdB?=
 =?utf-8?B?Q0ZDUjBZYXdlVisyZFcvQ1dab2FtNmVpb1BpVWZ2bkxxMW5OTnBEenVVZ25z?=
 =?utf-8?B?NmtPWGhGbmNwdHlvRVRyQTgydkMyYXc0ZzJab3MyTHhHa3F0czRhd2EvOGhO?=
 =?utf-8?B?b0ptcUE4UjdWY0Myay9jd3RqVEpsZjJ3TWJlZXdyd3llRWRuVnZDR3FlVEFI?=
 =?utf-8?B?c05DMDlDT1c1TjZvZlBlT1NjZUQyTmplSVdldDZZaW5CSmRITm9HazBrMmQ0?=
 =?utf-8?B?VVV6NHozaGVkNnhaVVJtdTlqaXByMWJYS09wUGE1QzhKRzV4VDVHUXZNTFVk?=
 =?utf-8?B?QTZoaytpdkZtZG14N2lTZFY3dTZZV0N0V3JlTUIydHQvdytCTVkzemVEQlIr?=
 =?utf-8?B?bE1HMXJiRjFhN0dPUkgwdGk4N0hGSDI5d0FKYTVGdlVoVXNkOEs0NGtubVNW?=
 =?utf-8?B?OHgxaElZMlBaMDFZTjhQRjFnbFhSd1N1SXZpb2pNNVRNNU1zUG5Md2tDZnl3?=
 =?utf-8?B?T09vQ2lUMWZjbURwSnhkVVcvUW05aTFXNnd1YUhmZ0ZOdVo4R0xqc2NSNXF4?=
 =?utf-8?B?Vlh3aG11eU5PN2ovNHVValo0S241MlRlcmJZaHV5dlY4cnZOTnpCbW0wK2xJ?=
 =?utf-8?B?REUydld0OW9OOEdVNlp4dDI3TERMZmFEeHhmVFRXZzl0VFBuR1ZwekhCU2JG?=
 =?utf-8?B?WG5tM21OVlk5dEQvbm9Cd2s1N291Q3IvMWpESDUxRjM2azFZL3hoVmcrb0p1?=
 =?utf-8?B?WUliZlJIakRaVmYzbzVJZGxjMHpjWkY3ZWFlajFtOHhXVFNacERNZkduMW1W?=
 =?utf-8?B?NE5xL0pBSVBsNDFHWkliN1hYSHVZK040SkI5b205amNGblA1UVhqT3ArYjBW?=
 =?utf-8?B?enVMZW9jc3V5eTZ6WG16dGE3TFphcUpSUGdxZFFrYWpwYVpTcWNRdU5qbVFk?=
 =?utf-8?B?QjJybEhqaS9VZGd1WVBrbnp2aFUxTklmK2FBV0RndUIwQ2dGaGQwQkVqV1Y2?=
 =?utf-8?B?VGs1YmplU1VJSDRjcTZGSVBTVUlsNnhJenl3ZXRoT3duZXVQUUprNUxqaDN2?=
 =?utf-8?B?bFVMbTkweHQzU0ZBRTgrTkNNczZwMGFBenBPZ1VjOUdUcjQ3S1dmUkRRRnlF?=
 =?utf-8?B?MHFDOWpyUlhYaVQrRnBwV2I3dm9POEF6ckNaclp6Snp2S0ZWMFhxSitkVE51?=
 =?utf-8?B?N1RlcHNNR2dWZFRQUmFCRFk5WFMvRVVyNnZ3bTF3dUpoMGIyWmFxOU9Gck5Y?=
 =?utf-8?B?VXRmWGl2dG5TMXIwWUtnMjJkcmw3Ykd0aEo4L2NjK042R2dTWVdUSlFlcEI3?=
 =?utf-8?B?ZklLUUg1SGtUMW1oZVdTdDMyakJUd2Z3RzNiQ1VJelZEbm9CWDMxRjI4K29n?=
 =?utf-8?B?RVVYNkExd2Vway8xMVNZY2F5SUN2aWxaU3RlWk1hajhsdVU5MnlSWGc5ZVp6?=
 =?utf-8?B?Z083QVlEMnBWd0pabXNjaDZQSTFuOUdNdWhtQ05pUnpPOUJjTGQwUlMvamVR?=
 =?utf-8?B?VTloTCtCbWszTU1USTlmSTFXRlRhczVCOWU4VVJHM0w0QUQ2NFhtVlgrZnJ2?=
 =?utf-8?B?cm9Oa21HRGQ3OTZVYjNrVXM2NzFPRkptRTlPWkdVc090MzRCRWd0QkpWR29T?=
 =?utf-8?B?TlorWG9OWFo2TmZTeTJnN21MVFM4cVRPL2RhbGRndFVOdkkzdlVSa0dLQUJW?=
 =?utf-8?B?NmFQQVAwbzM4NGQ3STFUY09MTjA5KytHNzB6UDNEZFN5RTI3UmlsTTAzTkRE?=
 =?utf-8?B?Z2VBUHVGVjF3UnBTTjlaRVA1SkkySjVRaGtVNHpCcy9Yb2FyaTNhZ1E3ckgv?=
 =?utf-8?B?VndFR05QczJvNGZWbThZZHp5V2tOUW1JTjViRmNIeUhtRXBCbTEwenh5OXI2?=
 =?utf-8?B?QlN3MkJGYXNsWFBReUU0Q2oxMlU2TmtHcHh5dk5CVk1vZ0tiT2FYUWs5SGI4?=
 =?utf-8?B?bVJSbWhiTHRMUytJV1E1RWFKcG9VaDM5Q2ErMVRrZmg0dTJ6SXB2a1hkRmcv?=
 =?utf-8?B?VXhYVTIvemxFQ2dBMnpUaDVJSTVKMVpOQ0d4S1FidVBIVW1FdHdyRjhLLzZF?=
 =?utf-8?B?WlRFdWhaK2ppTlpIZHhBY0E3R1NGMjRvZ3dybk1IZ3R1WkR6MitpWGxvWUZi?=
 =?utf-8?B?cFkyd2lsdjBLQ05FSG8zYlJzQWRST2hRWW8xcWVtZTZiQ0VkR3VTaG8xMXpt?=
 =?utf-8?B?ZW5MQjFDSlJrVXR6NTVZNm4zZEpwUjl6VlZmakJqRk1tSUs1cWNJdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b8dce2-49cc-4e20-9361-08de74b6c635
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 21:42:29.4225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +pBS/w+SzQxXnPBrniyWNGZLesANC+4mHcxyGhxCjt4gp1K1jr7fcykrl7Q5ORjhMAsHdcfx1xOiuFofRXoeDQ==
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
	TAGGED_FROM(0.00)[bounces-9115-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 6E39119DFE5
X-Rspamd-Action: no action

Use managed API dmaenginem_async_device_register() and
devm_of_dma_controller_register() to simple code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index dbcdd1e68319005dfab85a6c28b4e3f929f29132..57a185bb4076db1257e761e1c1be523178a5ff04 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -882,20 +882,19 @@ static int fsl_edma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, fsl_edma);
 
-	ret = dma_async_device_register(&fsl_edma->dma_dev);
+	ret = dmaenginem_async_device_register(&fsl_edma->dma_dev);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA engine. (%d)\n", ret);
 		return ret;
 	}
 
-	ret = of_dma_controller_register(np,
+	ret = devm_of_dma_controller_register(&pdev->dev, np,
 			drvdata->dmamuxs ? fsl_edma_xlate : fsl_edma3_xlate,
 			fsl_edma);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Can't register Freescale eDMA of_dma. (%d)\n", ret);
-		dma_async_device_unregister(&fsl_edma->dma_dev);
 		return ret;
 	}
 
@@ -908,12 +907,9 @@ static int fsl_edma_probe(struct platform_device *pdev)
 
 static void fsl_edma_remove(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct fsl_edma_engine *fsl_edma = platform_get_drvdata(pdev);
 
 	fsl_edma_irq_exit(pdev, fsl_edma);
-	of_dma_controller_free(np);
-	dma_async_device_unregister(&fsl_edma->dma_dev);
 	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
 }
 

-- 
2.43.0


