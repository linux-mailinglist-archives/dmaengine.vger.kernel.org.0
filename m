Return-Path: <dmaengine+bounces-9116-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCPSGQ1un2mZbwQAu9opvQ
	(envelope-from <dmaengine+bounces-9116-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:47:57 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB5819E008
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 22:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9766306FE0B
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 21:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F10318EFD;
	Wed, 25 Feb 2026 21:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SDQY6upL"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013062.outbound.protection.outlook.com [40.107.162.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457DF3191CE;
	Wed, 25 Feb 2026 21:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055756; cv=fail; b=cPogmqorKtx7snmeEr5gHuTS8ZlbxT9FJu/uXzcoTOXYruBp19LC/xgau34ec6YmIiz6JdCWjqHiHPwk/KMFKaBV4Nhk+fy01i/D3pRBRxR4eaV3/v9SRxjtABpAdJc2jd5N2EC8AysDgZPuT/6Tag+tAXjwDhXriQtNK3QKPKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055756; c=relaxed/simple;
	bh=EnenpAcNM5kwsiSx9owO0bkTtMp3P0rrERGNkbOld0U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TbaOyXvw939mJNtC4poqD5nrpAsnbJ+mZ6G/sDSA+0b85VMYKzz/jqr3F/PW5BcR46lxwaEHS1tm9dABAtXQ3dBmhXx3UGepE3Bl2MuhR2uuTXG903hl29PQSLmfvibl+9nvOXWH5aI/KmxeslmKDwMeKw7gyEQ0yS4A+Imp5P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SDQY6upL; arc=fail smtp.client-ip=40.107.162.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0MqIQbh6i+9qp7WIZMeoFUuqnaES3Erj+Uj8PxTtmIUNSOnNy+lBdcLnO9ARSzGHxeZyKxsmfKA5PHbUwZxucUMeW1J/Q6kRRIFKqUqL0CPF+CxpJyC8lfcDU4FbFa6EBUF5Sn8hGvHBjFv0lqrkUZfuto/pWuHVE2tdS/cXtbfEyDnlwB1Cqui6iBBxIuffwq2i0dFDpUGHcGCETv6RbL1Tr04x93LZ1dxAyYmbwKoJr5+yG5AcwkXB5NNg5jrIMdMmPgCgsKq6bKnXEr16RwFhTh/E/XssMQIRUpCmKUgZEcfjDqyZ0998Q5sOruRSVqRktMzMl/L73fpxmyGOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKHTJoW0OdCv6ItDL30lfR+2DbWAax94N1BMHszYaJU=;
 b=H1qAizUTwBcb2Q3gncIDa7r6e3VxItLLYoovDx42jH8R6CAZpGzVI1fTP9pGs4VVXgjUaNFDuRgI1kajEJgQReI2PjrmCw60ha2FvD/xTV53jkD/ZqEP9dAm7OamjPBmvHjjzXapj3K6dbz5WPQ/sFC8hpgJWgCfN1psRr9EoLoMCkpbleyqnYEDVjltwtccJZIdL/W+4Lyqe4s2Xs/Up4enKVpNmfoHWfkMAwus8Xm+xVoca34apldnv+JoAjgxr8NbykwisvBhZQ1X7nUaEzMo6CGft9tiEXiDJqK9gtzHQBfXr9/YjUSWRChM8k0njWe9FmeR7bxbs8rY5Z/SMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKHTJoW0OdCv6ItDL30lfR+2DbWAax94N1BMHszYaJU=;
 b=SDQY6upLN/4CuJ8nE3SLr2sJGkWwhljqJwCNQMCADLrkHkmaO6N3LM+t76sg55TFhP/syIzGkmgxsNxUfrLd3IAbV2uQpH2gvE86rGs4+AeJpNGt1EWCZUOcqwbf3h3OB35HZXK4yDsv9bQYMJjGS+7+iyAZWD2IwAIh6aJ+ApYyYCgxlaVh7q1UcBTpDJpA1une9PqECHxNJ/nyx5lftKvZqUVb1ri72JPiM4yoyOwpo5+J8IMars17hECf3LO1QxiH+Dl7vA5w3yr8RkbKPIBE9SBxKV+4aqVPYKEuFHSx0D12L/vp0JY5avVDlUuO1tINeM6TIcheT8/KC38RnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM8PR04MB7346.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 21:42:32 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 21:42:32 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 25 Feb 2026 16:41:48 -0500
Subject: [PATCH v3 12/13] dmaengine: fsl-edma: Use dev_err_probe() to
 simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-mxsdma-module-v3-12-8f798b13baa6@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772055708; l=3281;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=EnenpAcNM5kwsiSx9owO0bkTtMp3P0rrERGNkbOld0U=;
 b=TpHlOMDIkzIuxwJvyU9wTGDlkjyVICpxXTWzfpSw+XuLttI/2k++hegjUeVi80jAR707wL21g
 Zr5HYaJCNnvCOJfkrXkdHOrnp2XrHrGlbUbtnHMtotBZ8aiaLLDbwgv
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
X-MS-Office365-Filtering-Correlation-Id: 95313b0f-5c44-481f-5b85-08de74b6c844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	CBH34oyh4jMUr36y0jnKkLQvIi5M6rYISmEXDFAB17rAZcCTrl/2QsE7EFtjx7nrfdG+fNlvzQ2PgV7swUJmUKCm7+GrgR8NqF8E4MFfgXN3gVymgoCDWB1rHV1jykOkyN4adXbgT2A56Boo6486BrDqjXJcOLs+BoyPasEnQbRwIjb1UxsSYeRRWz6i5keoLyKuFczwJ0e74qrH49cmBbWnpvz46mdYx4ES2B/Y2HMFCr+Iuq69o/Z9lDrGKPJezc8NtmrWOFVPXQkATuKc7QKjKS3IOSbDegK6J0bfMjj2Y5+he8rS69/P/r4Sw6sf4EGsMLiM7kJxKZjdbvlJrEAw9MKBDO+OQHjJN0c8HJ2+zgdPmtzjG+fIIRvBxeLyre6CqpjpxPdLQRgo3D0vEXwloe6AfJw5hLYXWbZOQOtCFUTVapTUz/H/vkQshT4OQtxeHxYfWr01UwXAsHT9W/I3NKrtUPnUF72tfQp4X6JuCrmUnL+lOAxl8aEU2DrQ21i1HN8P3rHQwDOUeWX8RUo83H61i7eMt4JEa2OS6Q3jmmLPdhbdwTFBMQARdPRvyGCAqJCdK+Oj5eR8MXRTYBBmClnzxzNEe8wX8up5t18qz8EwotXwNuD8bOB29V83v+wD/FhSeGzMMfANYC1GaefQnTw6+AW1kApmWaNKa8mDsVFv020BHaU1BuoxTI9CwbYRuUV2RZF812UqYrWbZvdF74ysalsUr5P507XbEHxv9smahOM4dM7YV4E2lCcPJIi4UZ4vuCDT0FRn8HYggVnZImxQm4I3FDjBDkgCgJo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXRuYzFGVldqbDN5RGNlL2wxVkRnSlBOYkFONHZHckhLRS96V0VYeHU1L3ps?=
 =?utf-8?B?QU8wNUFhNlR5VU96Q3ROeHAzc1NxQzNkOHp0ZWxGNThYTmx0cnNKNEFZYTNx?=
 =?utf-8?B?NUZrZmdWdTRHeHl0WFdJeUdaRWVkY1o2ZEVTMjZxRG9VZHdDU24rQm5zS3VN?=
 =?utf-8?B?Tk15MEI2UkJuVzMxcnV0SUd3SHc0QUY3QmFvM3ZiZy9KcElBRHVtWHJrN3Nx?=
 =?utf-8?B?ZVhFQ0JKZjB2SUFpWXNoOTRITmIvb0toZFdkM1ZNYXNMdHBRVldPUlUrRjhq?=
 =?utf-8?B?L3h6U1JkaHNDNnhsRklBWVcyM2k3cjFkV2s0NUZyQjZSZENjbEw4Snd4bHJZ?=
 =?utf-8?B?SE4zWDFIdHB6RUw2Q25IelBYTzdPSC9WQ3MxbDY0eUs0NHp6TFJEa1h5MTgw?=
 =?utf-8?B?UEcrM014SjBxTnp1U2tGNjdmN3kzU2FmUXdVVndlakxJL21WTjVaNWU4QW5y?=
 =?utf-8?B?RnNLTXZsNWFWbVdEcEJwNTBGdjNwVVM3SDhHb3p4WkhodDFENFE4VDhEaitP?=
 =?utf-8?B?WllDSVR0N0RjNi9rZGV5NlIvWktJRjBxc2Uzd1BKdjVUNStXbVo1cEVoa3FT?=
 =?utf-8?B?emJ4Y0Y5UWpqd29BdkI5bDVWN1hweEIvMW5HZkRuUzlmQmNURU1rVjVqNVNB?=
 =?utf-8?B?OWZXOXBkcFVnaE04UGQ3UjBaajNJRUpWdGxaZXFYclBKaXBkaEtTWTNETXRM?=
 =?utf-8?B?R2dCSkUzU1BuRm01WUkzWWdzZ3Jla3ZNbEw0SVlIb1Y4eGFWRW5BQXZ2STEx?=
 =?utf-8?B?Q0NkTFJEK2QrR0tENGl5eThjN05DRU5YcjlsczhkREVvWmdwSWFWdXZLYnpG?=
 =?utf-8?B?MkhHMWFHYjdaMG5VMHZ3OFpnUDdEMG8ydUkwOFdackNwMW1YRGgrQ3dWTHZB?=
 =?utf-8?B?akRod3ZwM3NjYVF4TTlHMTJmRVF2OS9NM0psTGZubXk2QmJQV2V6b3RySHlZ?=
 =?utf-8?B?Q1NET0oxcTFIQkFSSmRCbk9GZjdPbzFUVXZCRWNPa05Namh0c2NkdmE1Z3lR?=
 =?utf-8?B?QlFFN3NsK1daYjJ2L1pkbGpnTDBSVnd5QVZmOWYveTlBbEdkK0pjSWQyTGV3?=
 =?utf-8?B?M2NDTGhVcDl6UjQycE9IaVlYdU1MN09GUVNsSXpZclFObk41Z3dnWW9YbjND?=
 =?utf-8?B?MU9wYmhBR0NldE5KbmRMaDBMVC9veDB2bmo2eForY29qRTczSUQvcTMyY3E5?=
 =?utf-8?B?cHo0UjVHWGU4V2ZOQUVqdklXSE1mUUROSVBzbS8yNVVOaEtYZGFyRWNCRitN?=
 =?utf-8?B?aWlNTlY3aldWNjcwZHphNU02SVNVYmZad2pBdTdyOG13WUo5TkhUT0g0MXFH?=
 =?utf-8?B?VFk2bnZLWVEvT0VFLzBmN2VQei9YKzdxaDRFYnJzZFdoby9PRy81VXduejZz?=
 =?utf-8?B?amd5YzA1S283L0NmZk14Q3Fhc1RjRERsZ1BZb0N5UmhvbGpzRDBPUjI5aGFF?=
 =?utf-8?B?RUtFenNIZFd5Yk1Ud1UrYWx5Q2FWcUN0aEJIM1VnMW1vNWxic015VHdDaVVZ?=
 =?utf-8?B?UlRMdkhHeWdsWDBNUHdFRjdacjhwL1hycE5MREVGa2VnVEU1NHpxSmFINFVj?=
 =?utf-8?B?RHI5RHVzYmRWYnhwMVdJdXBlcGZ1Sk4zSnFqVTFiaktqcExQWHY5Sk5EYng4?=
 =?utf-8?B?V3ZjaDU4WGorRGMya1VvUTJ0Qkx6T0lBTkMrYWJ5aSsyZkNWRVRwSW93em9k?=
 =?utf-8?B?YWdlUGJ4dHVhdlN1TmJqVlJyQTZyZFhNRE1LNDFKMGpYcitqU0lRVytabVl0?=
 =?utf-8?B?TVpJOGt6eTVJbkIyaGJzMm1ySUdwRHRHRDhFOUxxTVNFNi8wdWxqM0tKTkZ1?=
 =?utf-8?B?eTRZWjNBdDJTWEMvS3JrbW5EdFBlckVRamlDL3UvSVRMSUszQ1E2R1k2RHRw?=
 =?utf-8?B?T0xnSUR3elAyeXhlTTA1Y1BEcDFuOTc4c3Z2VmlIZzZnNURSTjg0emM3T2Fp?=
 =?utf-8?B?WVRreUZDeEFxVkNxUGF5YzFyblpLZTNjQlhhemRYd2ZBR0l4MzNJU0t1TmZF?=
 =?utf-8?B?eW8yZThIZ0EySEdTY24wYXdOZEIyc0NaTFBucWl3MFovTXpsRjV6TkI4dUdj?=
 =?utf-8?B?cCtFUi9adm84RzdMdXFBTmMzU3ZVaTdqQ3pydFd4UWJRQ0JOTlJNWm50ZGNa?=
 =?utf-8?B?VWJZQ1dPdnk3WWwvQk5sZFZuak9RbTY3OWxIWUJ5T2N1aW1zV0xvb3hsb3lP?=
 =?utf-8?B?UU5rOVVuditjY1ZiSjdtemI2T3IwWWZtSVFUZUhrb1hZbTA0cXlvQkRhUndC?=
 =?utf-8?B?czhwZWg4VlE5MlBrUk12bTNQNFFXTGZHTU1XdWF4TFlDVWZGRk9Zc1c0dHdY?=
 =?utf-8?B?dTNRQ0FaankxWTBwbERNR2FRQjFYYzNQRnJLci9zTHlHSUZIS0tBZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95313b0f-5c44-481f-5b85-08de74b6c844
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 21:42:32.7162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ot/zdhgPL+ubFLhiDP989fHoFeBriezqLMLl1ovxybENe3VgbwnumPFENnoqaUaWMyZOzkNJg9f1PX5gcRM+Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7346
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-9116-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:mid,nxp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: BCB5819E008
X-Rspamd-Action: no action

Use dev_err_probe() to simplify code.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 47 +++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 57a185bb4076db1257e761e1c1be523178a5ff04..950538cc88830a7f899449fe6dc43efacc9d2e3c 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -709,16 +709,14 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	int ret, i;
 
 	drvdata = device_get_match_data(&pdev->dev);
-	if (!drvdata) {
-		dev_err(&pdev->dev, "unable to find driver data\n");
-		return -EINVAL;
-	}
+	if (!drvdata)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "unable to find driver data\n");
 
 	ret = of_property_read_u32(np, "dma-channels", &chans);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't get dma-channels.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Can't get dma-channels.\n");
 
 	fsl_edma = devm_kzalloc(&pdev->dev, struct_size(fsl_edma, chans, chans),
 				GFP_KERNEL);
@@ -742,10 +740,10 @@ static int fsl_edma_probe(struct platform_device *pdev)
 
 	if (drvdata->flags & FSL_EDMA_DRV_HAS_DMACLK) {
 		fsl_edma->dmaclk = devm_clk_get_enabled(&pdev->dev, "dma");
-		if (IS_ERR(fsl_edma->dmaclk)) {
-			dev_err(&pdev->dev, "Missing DMA block clock.\n");
-			return PTR_ERR(fsl_edma->dmaclk);
-		}
+		if (IS_ERR(fsl_edma->dmaclk))
+			return dev_err_probe(&pdev->dev,
+					     PTR_ERR(fsl_edma->dmaclk),
+					     "Missing DMA block clock.\n");
 	}
 
 	ret = of_property_read_variable_u32_array(np, "dma-channel-mask", chan_mask, 1, 2);
@@ -769,11 +767,10 @@ static int fsl_edma_probe(struct platform_device *pdev)
 
 		sprintf(clkname, "dmamux%d", i);
 		fsl_edma->muxclk[i] = devm_clk_get_enabled(&pdev->dev, clkname);
-		if (IS_ERR(fsl_edma->muxclk[i])) {
-			dev_err(&pdev->dev, "Missing DMAMUX block clock.\n");
-			/* on error: disable all previously enabled clks */
-			return PTR_ERR(fsl_edma->muxclk[i]);
-		}
+		if (IS_ERR(fsl_edma->muxclk[i]))
+			return dev_err_probe(&pdev->dev,
+					     PTR_ERR(fsl_edma->muxclk[i]),
+					     "Missing DMAMUX block clock.\n");
 	}
 
 	fsl_edma->big_endian = of_property_read_bool(np, "big-endian");
@@ -883,20 +880,16 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, fsl_edma);
 
 	ret = dmaenginem_async_device_register(&fsl_edma->dma_dev);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"Can't register Freescale eDMA engine. (%d)\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Can't register Freescale eDMA engine.\n");
 
 	ret = devm_of_dma_controller_register(&pdev->dev, np,
 			drvdata->dmamuxs ? fsl_edma_xlate : fsl_edma3_xlate,
 			fsl_edma);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"Can't register Freescale eDMA of_dma. (%d)\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Can't register Freescale eDMA of_dma.\n");
 
 	/* enable round robin arbitration */
 	if (!(drvdata->flags & FSL_EDMA_DRV_SPLIT_REG))

-- 
2.43.0


