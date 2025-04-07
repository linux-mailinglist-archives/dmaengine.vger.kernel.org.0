Return-Path: <dmaengine+bounces-4843-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D0AA7E729
	for <lists+dmaengine@lfdr.de>; Mon,  7 Apr 2025 18:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDE9C7A52CA
	for <lists+dmaengine@lfdr.de>; Mon,  7 Apr 2025 16:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3C6213E88;
	Mon,  7 Apr 2025 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AtWjVqXA"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2041.outbound.protection.outlook.com [40.107.103.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509062139D4;
	Mon,  7 Apr 2025 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744044421; cv=fail; b=oCF4y9ParxAKrhsrpmepXwY5m7Ic5H8kZOAIvvD7isJUB7j6XCxy9Y4jdZQKlh4Eod6j7a+saYRItQnpL1R4MwXI96by42wc+Dc8sL55yj8yrZ3qp7fdskG83lC1AI50fqLA+vDvnmaIIJfQilMYzd8ivtyrnA/OTTnym2nLaFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744044421; c=relaxed/simple;
	bh=X6bjoWsFX/079hJtkg6bk5pj0pEhM/n3bAx3HbraZ+k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hCZ8q38KLoW6P03Nu0GZzQjJrrgxDoewZkqbMOnaNVAM8euUZnhxQE87Z/DUPiIzdinPDVkBkuPkEne3fpjvcfFEfuoefutbMyBmXwc92ZW3ygogHZ70jWAcAOMw03veifhOTJupTDUY3Ciio0HMW9tUBu/1sxv7hTSfi+bolNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AtWjVqXA; arc=fail smtp.client-ip=40.107.103.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGZO+vT8AhTBf92mUWIOZRPLI7xZc9KXHwy0nb1cy69S57X//ImyQClPFvE4nnZQ6DGHACBs11KzENCVln5OqTR6VNAf2k5C8WF7dC9ZVZZJ4fY76nid1UkGjzTMCNi+S7W9xtCbLxeIA5TJHykWu3Y5vXOTfw7uqDb0LXNmSbWZ9zCExossLflW5IJjdO6jHxLc1gUCggYRHtyqOTk6IbaoqZMFxkx/qV9s/Ymo7n7SqnEG50vnZfTm5NW7AClpmuW81Hb8BUwfF7jYN4TLmUx0S+G6t3fIhGN2yead2lEofFpTfacFs9vEaasHL7HrA1xmB9UzTZa/h6jxODIIZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ry6I4UZZpSwJthTgqZO2PxmG1uzefuqJ4HOXz4bGQKE=;
 b=PvX8LiuMtiPyR3Op1dIrt1fxdWyL+K7b3wDQLQSX6X6jbPnj50V4fh1W7gsRifoi/hUmYtoSIH+snd8gCSjGulWps3xpvuAO82JIZIRGaMB65HCXLX88VSUJXhT2dJ91YLxuPlc63HEzce8SyOLx8d7EC1+iakUr4uU+2iscqY0qG81pX0tK5y1LZocIxFpfmoz83wGZLbUQwE+B6ZhRLFVQn8pVNiOUqLAgCmkOe8jxpBSl69Y0bz+p9hu8yvpjW49Cnc6n+85rTkgfz/wJ+Mlh6J0hCMv5PdX4eAS3LBcOotdX3ZnqsgfHbKGOOZbCX2Gt7lT97URs2OnZiw/mtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ry6I4UZZpSwJthTgqZO2PxmG1uzefuqJ4HOXz4bGQKE=;
 b=AtWjVqXALLVhrn9oGj72ijD6Dmiw3Zo8fyrE3e6Sc025aygXzbTmQRwu+Bk4AHHY0lCLtunno+7jieBPXxcvWUqMukF6BDFSsGkXz0/mAlRuhYxi4V+w9+gg4pfaKMuqNQncZ2uFHOPUJJhylaI0r4FEUaKZ9DVf65X+/18L2uNMR/zXo6ZuQx8kHYXObfxe5bnN7UwX77B9FaNls9F7HDixJ8G3lCBfClEwEfPYg2gJREyoP6HP/eubMQNWR7q8+sepIChMZXNac36vPx24o9hDyXMWBi0dsENYnrNWPrkuSWvapDdHsYEJYPAmkuYYLTB6E3hGhTnJY7EQO+cq1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7029.eurprd04.prod.outlook.com (2603:10a6:20b:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 16:46:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 16:46:57 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 07 Apr 2025 12:46:35 -0400
Subject: [PATCH v2 1/3] dt-bindings: dma: fsl-edma: increase maxItems of
 interrupts and interrupt-names
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-edma_err-v2-1-9d7e5b77fcc4@nxp.com>
References: <20250407-edma_err-v2-0-9d7e5b77fcc4@nxp.com>
In-Reply-To: <20250407-edma_err-v2-0-9d7e5b77fcc4@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>, 
 Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744044406; l=843;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=vAG7HoIDqb2w3aEvYT2e5p26tSed3G829srp2fLSwGk=;
 b=puZ1dj9gl1gKP0Bo16v4TX91viOchHH3/J5V/rtV8GXvDENH298B5xkez1QPTzGlnFr3vJo9e
 68aKvp3ynaPC3X7OBYhsMxbWV444T11Li8w4CqPFOQ23qAaT3SPvzio
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0243.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::8) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c7c0b4-c146-40d6-0fdf-08dd75f3cf38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0pEMTRTNjBneUxVbHBHL05DTmxpSGVoSXNRMFByZk9rakR5OTcreklpY1lL?=
 =?utf-8?B?SWlPS0VVcjlnY25Yb28wRnZkdWcrcnVNR3psWmV1Tk1qcitRT0sxditBUEY5?=
 =?utf-8?B?eWduU3lWU3hJYktoVjZWM2MreVJYS0ZJcjVEckRQSWlDZkJTVE5paDVUZEpI?=
 =?utf-8?B?MnoxaDk4VkJMbFRTVGFxK1M1ZFZ2SlJEZWZZL05ZbGlFTzRmMEVLcitrNHJY?=
 =?utf-8?B?MXY5bmo5VU1PdzkrOTdPdStxTHZMaiszVnRvV2tRdm5YT3dhNTBRQUdMYVNH?=
 =?utf-8?B?cjJqLzR0YnNyZHU4cTNwUG5PTXdNNWdNRjJqL3RNczMxWFdWM0liNzJzUXNM?=
 =?utf-8?B?c2FweWRISEhCbzE1T1M1ZnE5cHhNMmhZenJxazBldHFKRWNpc0RUcEFXYWsy?=
 =?utf-8?B?N2JIN1ZLR1pVSDNtWHc1NmJ5Wnp2cllnSzNodjFqOWYxWmFuaTlqKys0MWVt?=
 =?utf-8?B?Q2FXOVUvSFFCblYrMHZLdWtpSnNyaG92L3RxckdIcjRoKzkvRTUrbFkyTHRV?=
 =?utf-8?B?dmZWM052L3BkR2dIbFhkdm1OTUNBcmZxbXczS2pVeVVZK1FGQitZb3ZvQUhO?=
 =?utf-8?B?VmNJdXc1K0p4OVlBbjlYL0pUWG0wZi9kU1g4TDlTM0VMMG1jVElrWlFIRzJi?=
 =?utf-8?B?N0hTdVlNWTFhMzl6NmI4SFprMmpnTWlFNEdYL29WMFJOQUdLZzRZQlg0TmxI?=
 =?utf-8?B?MUp6cFc1aWN1ZXJnM01ZWnVhOFE3N1JHOVV1WGNScWZTZlM3bGJ1VDhpd0Nz?=
 =?utf-8?B?N2xCdzJKanBuRkFPZWJUWUdCMndESXFaUUVXbndtZnkwTTdnRkFOZnlzT2VT?=
 =?utf-8?B?RmJTbm1wUXhrdDlvSmNGcTdEZjYyY0Y2aVlMQVlpc3hCR3VGSGhBbHpRVmt0?=
 =?utf-8?B?N0NIZ3dpTEZmT0hYT05yZHF2UW9tcmlEbDV2WUN6TTdtY3N0Nm5weFZDWVMy?=
 =?utf-8?B?eVpTRTdGd0xQV1JMMEg1cWF6V1pwTlM3QnZDVEtNc0VFOFhNMEdmWUI5cFFD?=
 =?utf-8?B?KzBkZDkwVFUxVW12UitmUjd0SFJNMTVBZDZReTN2Uzc0M3prYkc0VnJ5cDRG?=
 =?utf-8?B?RWNtRC9oV0dGZkhVa1BPbHNOekx1eTRsd0c2WnpMQmFmKys1Si8zSDdaRVhX?=
 =?utf-8?B?bGFoVTFGR1VRRkMrWFdwcTU2N3haQWZWa1NRTDBRaWUwUVRXWktuQ1NVQ2pK?=
 =?utf-8?B?b1VYbFA1UmJhczlLSGluendvRDlpZEZRKzRGRTNuK3ViZ3kzeDZNa0xIbjdB?=
 =?utf-8?B?dnVHL1pYNEszS0ErV2o1T3psNVJTT2VLamYwYVJwNm05SXo4S01EdmwwUFZ3?=
 =?utf-8?B?OVVKYW1HS1ZmaGpEbWhSbzFtUDN6QlFkTlBldG5sZ3haci9ocjdzREdBdHpQ?=
 =?utf-8?B?eXBNSFFZTHRGQVBHT0hXRzFIME5GQ3g3ajIxeExjQzFBL3JnMzMxY0UrMm1v?=
 =?utf-8?B?R3R5L09VRXdZMjNHdkVzTU1ZNHJ3OURUQjFIWEdacmVOTmJ0RXRwQ2d3Vi85?=
 =?utf-8?B?cEJVQjd4VSt4RElMa0xST3JGU3A0WXVKajJ3MzJoMS81MFU2RmEvZFNyVkkv?=
 =?utf-8?B?ZFBTUFlBcElaUmhBVjMzdzczcXNCdCtINHIxci9kNjhqR29iSU0yK1cwTXN0?=
 =?utf-8?B?OU9sSzhGMWZFMmlzY21MbFMvdzc1K3dxRi9CQlFlNTFkSGdVektKNnNhNTZp?=
 =?utf-8?B?ZGhTY0pwa1d4SzY2TWdDT0ZNRE9vcEJ3VGJyMFZmUXUyV1pHYW9yM0g3M2tZ?=
 =?utf-8?B?ekcrNmNuK3dIR1VkYlplQWREb0lTTWtnN1VCQlVrRTJlbTlxZE8zVUdlVGdy?=
 =?utf-8?B?RVhVTi9XVGMrYzcyZ3BzZElaQkJWSHMwNnVTd3lzNVZxUlBvVFhkVHpUQTlR?=
 =?utf-8?B?aDcyN01QdjhWcXRrWTU1cHpRdU8yeTBUeGhXWFh3b25OQ2NoTzBuZzZ0OWdh?=
 =?utf-8?Q?VQC8h2sajPnnhfOCDsLlIJRJbhaNg2P+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnJNYWdsOEU1Rmd3bE1sNlQzZFN4MUwya25EVjE0Qll5cTY0SU96b0JiOWg5?=
 =?utf-8?B?REo3NExwV1JuMnZKcmM2bEVwK3AxNVpQT3dFUnpnakd0WGF5NjRoOEZxSy9z?=
 =?utf-8?B?NENCOVRDL1VsRGFvc1VubGVIQUlKT1lCK2h1bG9JQVR3L3g3OXFIQzdrMlFE?=
 =?utf-8?B?c0tHcXBocUUvNEVPdkdvdzdWTTVQb3UwVkV2VFhwZFhNYVhsNnNvYVcydkxk?=
 =?utf-8?B?UVZaWXh0eUVoWVlaenlmZ0Q3dk9uTzlIMlhZVjd4Z0FhREVDQ2Q0d0J4bW11?=
 =?utf-8?B?Z3M2QWlpMXAxWmZnQUtJZjBHOWZ1bUdPSURnK3NGL1l5QldRTEhCRlJmY2x5?=
 =?utf-8?B?bkRFbklGdncvOGthVmNxTmhSWEhNMnFOZUFJZkRhYlMvR2FwTE8rTGk3OXlw?=
 =?utf-8?B?Uk5xeWJtci9CVE5mZG4wQVVsY0dPR3d5MmF2MlVha3p2L2phY3RLNHcyRTQ5?=
 =?utf-8?B?TFJKTlJMVTNWdFd0SytvbjRHbElBU0dteUtTMkR1d0EzakdlU2M0NkdLTVJZ?=
 =?utf-8?B?d3JaV0pjR05HSjFHTVBQbG1xMm40cmp5RWMzY2lCd0F3ZWd1SDdDbWFTd3h5?=
 =?utf-8?B?ZVJ1ckJJNkthWWNtYmQ5d3J5NThwS0E1ZWdiaE1uelJrZ1poR0JBSFlyMGtl?=
 =?utf-8?B?aUo1OWN1cWdCclBlZVpCc2phcmFhTWZoS1A5T2pvSXp3blNlZS82akNkSFBj?=
 =?utf-8?B?UlhJWWZXRk1zWlhkRWFtQlAzZXUxSzEzc0pnYWVGNWR4NUxTN2NuT3luZnFm?=
 =?utf-8?B?VmQzZTY4bU1lV1BsK0ZpaEZOeTRYTkh1akdVV3U5Z2VPWUlkb292b0pzUWlI?=
 =?utf-8?B?alkzNnpiU1AxUE5xY1JBYUxzYVM4dFBrdG9xYVFoUUdXRWFNd1QrYzlPU0pP?=
 =?utf-8?B?VjR3NS9SMFRST3ZWTlBJNVNSdmM0UnZYdlNkbUQrYWJQWFhlU201RFJZR2F0?=
 =?utf-8?B?b0g0Z0RhSk1oQlFyM2RxbElBYXNkTEViNzZzSjBwLytLaldWMUZURGpnWE9M?=
 =?utf-8?B?VjBLTHZnc0V6eUFCZHJnWWZEelByVXJ0VUQ3ZTdtdktWYWcvd1FRVXdsaWww?=
 =?utf-8?B?MlpOd1FOTm4vT3hGSlFyUmVCTDAxUUhMT0ZDbUZVRTU2dlh5dHFSQlJxYTFo?=
 =?utf-8?B?RG5taHBrRisxYmh5Q0NhVGRqYms0U1RBQlFMRTJ6UDM3RDRuSytYcjBCQTFD?=
 =?utf-8?B?MWVJQlAwVUQwZ2w3YllsYTVGaEplVE5Xbnh3SllMMmR0R1RtcllUYUtncmM0?=
 =?utf-8?B?Q1V1aHk2Q2hsT09oZGRMNVRKdHlFNlArOWZEUndFNVlxRnIzaVZZSm5QUFBp?=
 =?utf-8?B?bXdjNnlXaTFZR3JmQ1RoQ3MxWGcxcS9adU5rUThHY0hnM1BMMlk2NW8zaHhB?=
 =?utf-8?B?dkJZTGVFQjQ4SDBUeVNvZXVadEZSM0UrbmZIMnAvcDg4ZDFtNnE1dWkwT2tU?=
 =?utf-8?B?VHRYUEtIdnd5M0t1Nk11YTI3Z1Q0cFNLVGJ2VURYeXh0SHRGZjJhRWU1T2pC?=
 =?utf-8?B?aHduMUErT1kxNkNNNnc5UWtuQWMreDdxditFM29TRGRkcU1IWjNWb2M4WWsx?=
 =?utf-8?B?N1NZTjRYUEx1a0tjblNMVVlIWmVESENoLzNFOEJhRk0vdmp5ZFU3WkMwOUFN?=
 =?utf-8?B?dEttYVovZDJsbDRvV1pjZGJ3TkFtbmdlS1h2NkdaT0gwWGkxWUFucTJsK1o4?=
 =?utf-8?B?V0FGTGJ1cFNyRlowRHVWcGxQNXBFNUUzWmc5RzRHQXg3d3hIRHp0alMzT1VN?=
 =?utf-8?B?MlVMNUlNTWUvZEowL2Y0M2dKTGxRYUJFdnpnUDBGYUlEbEwrVzI5MUw2Qlht?=
 =?utf-8?B?MjRmT3FVS2hONFRmTnMyVXdsU0haUUl3c3FlVFZMU1pQVXVpT0NORDZXamtl?=
 =?utf-8?B?WnIzUDgranpPYUQ1MGdjOFFtMWtEaVQvU21wSUduQ0FBd2RpV2hHUi80UGdq?=
 =?utf-8?B?a21xWmtnNjV1WE9pdktBMVVRV0tQSThucEd2bFZHU3Y3SjVweStMb2RZL0th?=
 =?utf-8?B?K0JvWVUzcytYVEU1UGdnd0VpajI5SVVoZVR5TVZER2wzaUo3T2t2RkJ1TWNh?=
 =?utf-8?B?cXRSUmMwU3pQZmpPVzJJQzlaNDBuSGNjc0M0MU52TmIzdlhTeW9zeEwwN0wr?=
 =?utf-8?Q?jZZT4ofzASphIIjlzteuNhUqV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c7c0b4-c146-40d6-0fdf-08dd75f3cf38
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 16:46:57.3920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWo+Is05+v75uqtFU9I1gS1KcuyM+mnN0yyRHFxGt5/uBXx+6PJz8Dv83bpjKAFznb85wuYKL+iIZSZCJq2VaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7029

From: Joy Zou <joy.zou@nxp.com>

The edma controller support optional error interrupt, so update interrupts
and interrupt-names's maxItems.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/dma/fsl,edma.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index 950e8fa4f4ab4..fa4248e2f1b9c 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -48,11 +48,11 @@ properties:
 
   interrupts:
     minItems: 1
-    maxItems: 64
+    maxItems: 65
 
   interrupt-names:
     minItems: 1
-    maxItems: 64
+    maxItems: 65
 
   "#dma-cells":
     description: |

-- 
2.34.1


