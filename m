Return-Path: <dmaengine+bounces-8618-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGWjNrvMfGlHOwIAu9opvQ
	(envelope-from <dmaengine+bounces-8618-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 16:22:35 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCC2BBFC7
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 16:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F39AB3042B76
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 15:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2E8376BF8;
	Fri, 30 Jan 2026 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aQygtZ/f"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010009.outbound.protection.outlook.com [52.101.84.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEF236EAAB;
	Fri, 30 Jan 2026 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769786509; cv=fail; b=nESbDyqjaLG/2FqCpTLLJyXqIOLqXoNj7RJaW2OnDW8VxszmNRW4dvEI1vsehAoPlcbwmo8tYh3jcogLpRrZ40oWIOEGMj2FKqSO5tELAfA5uxlfTTgyJU4uCrl3VpHAkmTFuuEdl+ENh8pUXXArIIa3QsIl6H05NkPAoL/OVWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769786509; c=relaxed/simple;
	bh=JexKgF5L9KvxquD8OTgy7TrkmLj3CofvUQO9izXpewc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=m5L+t9qeVybdjbAZ7qJSGp/YjoWM440+PdbLw5qXwOi/QSp7FBE+0C7uoZGtyuY+zmNxpjFpM33/Y5R42qzHxEUxekLnSnfC4SlqnBH7smd2vo5/25g+Y8r6reyGwEhvvHIZJOBY3eWLwxuSLBZSjL7RzRkL5tF0EeAQbl2sqMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aQygtZ/f; arc=fail smtp.client-ip=52.101.84.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtTiEVCCT/FW668KJeGxkjGDj3zZA7OVPwIDI7ywyNvzIO2X0HfZujVLHFgT5SA5uKs6UrvVVbj5Dx2WJ/JJo8MxqoPptpIyAWro52k45Fv3i7Kd3YErvxKOrb0eJTO4u5gEcArBiqLWKaXqOhpOClKrNc6gM2e1nzQSt9LY7S3hntWwIVesTV6l/elYBgDdS9Owdz4Q6RxTmtKwb8AehBcNKT3PHxqeJV880G7OiOSx/up8m3ZzypGtHxB0LHzujdpM70IihYk6jb63TuuzmNE9iyWEwhEOR7RITBNbC6M5U+OHDshZ7dn3BnQJ/vzWxazESg22KnytMQEGm+nXrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AaNv9pxS0ijWue0bfXgsNX3q9hNRlG/JrKnHmKn6H90=;
 b=QP4CUQa2d5QdQyt9FIK4QRt4G9V812TltmUb0/PBkqS4SqOnhzOKdj8XiH6lROCtkLYSq0TXSXKAuKFXyRXC98IdzOZQJz2bpW4hbUEOLM7kg4355X2/UXmR2Gg8GLBGBFj3QBPwBQCqiMoEdfCdKMkK51r79SlxfotUmk5XIxI1FovKg/gzuolbI7qxSj3Y2rcSl71Oz4ivItH25nNwEcjbVkboOCyqNoJfDE9YT5LiKiSXDCgjbND3h9Z9z/pNEjiFmpgM/0RJfYXUZNo1fQv/hK1UEXgkTHubcGAnkpTyaDhDnyRSN+3kQO1II+gRrg1TXoMDH/5dsoikceRztA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaNv9pxS0ijWue0bfXgsNX3q9hNRlG/JrKnHmKn6H90=;
 b=aQygtZ/fhktj18z/ImpGrysMOwmWXnbAD/IEFJTNJmJhzmXcPUAx4iTVv5op2AJ2ZNS6n0Z4PNIp8ov8kRjnHmqvpWrBRMGjTR53jcQIWZhV2RDv1NLqEINLZ2khhNy2/DFL0pgdHgk9IWaHkNCGfmnyFuXKKktzBS09eeZl56mEAZARSTC+ag3nZp3DhAmyWpo4ZMm8IQY70GDTcn40+MTEZ9J1ROiGHS2Fw4Fr+EwZnXCXFo+JQ+r5qvLw+F9w/XmBImS3mJq5acc0Lt3D0xVa1gu1q7rHP3Jvx78qFz/4W7EOHQpV0uF+Gv56KSVsmdQCpPT9YGVBQ1BGak65YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI1PR04MB9738.eurprd04.prod.outlook.com (2603:10a6:800:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 30 Jan
 2026 15:21:45 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 15:21:39 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 30 Jan 2026 10:21:15 -0500
Subject: [PATCH 2/2] i2c: imx-lpi2c: use dmaengine_prep_submit() to simple
 code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-dma_prep_submit-v1-2-2198f9e848fa@nxp.com>
References: <20260130-dma_prep_submit-v1-0-2198f9e848fa@nxp.com>
In-Reply-To: <20260130-dma_prep_submit-v1-0-2198f9e848fa@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Andi Shyti <andi.shyti@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-i2c@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, carlos.song@nxp.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769786487; l=2069;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=JexKgF5L9KvxquD8OTgy7TrkmLj3CofvUQO9izXpewc=;
 b=kYGQUTqOxtjYipRHz7ymIXPBZBU+ByjQtRyUUQZBTfj4THel63zRnQfIyHebgYIbzjRmqO9Lb
 FaC6muCOUd+DHOzkuS43Z7CDyajY2vUwHdUNgf1hSkKveUVjUANZDRO
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0063.namprd17.prod.outlook.com
 (2603:10b6:a03:167::40) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI1PR04MB9738:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b78593-e3ed-46fd-ef57-08de601343a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXQ4UTlSdjV5dm1ZUUp1SHZEdTJoTUNkeENnOW1RekpoY2MwKzN3Y0ozK2hH?=
 =?utf-8?B?KzJuQW92ZmlndGlmS014Slc3Mm1TOHlIeENhazBrREgwaExGK2FNTlRWRjQ5?=
 =?utf-8?B?TnNHUGJHRWRWd2JwZWtwWkkvek1TVlhQb2VSTGxLaEtUM2c4N3ROeWpoL3JC?=
 =?utf-8?B?UjZXWXNRVEo2VVk1bnM5OWdhMW44TmtsMzBLZW5VS2xmY2dJaTJ3Wk5idjRI?=
 =?utf-8?B?eEx2ajI5MExWNTYwcnFSRko2SDRzcUpJdzdSNEVINWt0Skw0NllIMlkvUE5o?=
 =?utf-8?B?UDBIL1piTEtlTThkYlpPT0h4TTdqczFnay94UzMyQTlveVRHQTlNYitJNlYy?=
 =?utf-8?B?OTY3NGxHajVyRE1hQURDUWV4d1k0bmVuZ1p2eG1GL3RnV0M1UGNoNTJwVENV?=
 =?utf-8?B?b2czbkg5eGgwamUrRnFKOE4rdG44QzRBelUxZmJsRnpQL2Frdnk1VjVWY3cy?=
 =?utf-8?B?SklSVHpORGNvZHVFNkdyL1gvSEVkV01NbEcvbjhVWUx4SUYzM2hqeUxNVUlO?=
 =?utf-8?B?QWxuUE0veE1sclByaHhKdVJlWjIvODMzakJaVVdYR0NEOXhrSXkxdE9YUXpG?=
 =?utf-8?B?Rm1MWFFaY29WL21lblZYM2FPaUZQVjRkVXBiL2VhYlRZa1VQUWp3VWIrcDhD?=
 =?utf-8?B?Q0ltZDhvVWxpbXdhc3hjZWhBS1lXNjJTMzc1aHFxR1ZRNWNqb00yaVR5Ulha?=
 =?utf-8?B?NW9ieDlSdTNIS0xiUWxrdFdkQ2xmbUtXWU5vZ3RlNXg4S1p5UHNsREZ5Tyt6?=
 =?utf-8?B?ODJsWmVFRERwWkRtYUZPM0RzamVjSHVZaTNwTzZVTGVydmNCZWVxRkRPVEI2?=
 =?utf-8?B?RXBaYmF0YmEzcUxRUDV6Zm8ycTV0NWtqaERVUGFyTXN2c3piRmMzVmVtNE9J?=
 =?utf-8?B?RTBYSk0zQTF4Z3NSTzJ4YVp5MXBjYUROMW5DU2JCallZbmdCSFBOTExTSmdy?=
 =?utf-8?B?Z2RrZDVoRktiaCszVGd1ZXpOWXRmZXl1NjlkbG4xNVJQSHhCOXFFeDA0WHFN?=
 =?utf-8?B?WjY2M3hHRVFTREZ1cm1OZGhPUTloZmk0cTJ2OElMV3JVaGRiYVZLbXVzUWo0?=
 =?utf-8?B?c2pJamVYY1ZLa3ZyakduajBQTFRCYmV3a2MzS045d1FQYlRpeEJSTy9jL1JJ?=
 =?utf-8?B?RWpmQms5RHBQOVBKOGlPb28ySElQa1dNeE0yS3gwNlliZGxjWkxzTThUV05V?=
 =?utf-8?B?b1ZSRDNMNld5ODlSUzZnNldSOWVYNFBkMk82WVg0Z001MEgrakRNekExaEt1?=
 =?utf-8?B?SDhYcG9GTGVmMjd6aWozYVNIZm5NUFdycnowUVNpTlg3azVBbU1HcE1MU0Ra?=
 =?utf-8?B?cTJDaG40OGFHbHp5V2FpNnhmdXZITVJYclhQcTZCcEdyRndSeDRmcXp2c2Zs?=
 =?utf-8?B?ZTdWVG5qeGVYbVFmNk9Qb0kyTFRSSDZRQ1EzcFJMbVh6VmtScENRRm9ZK1FH?=
 =?utf-8?B?anhRcCtGakFFNldhWDJvYk5uS3o1QkR4SGN4ZjM2UkxMQjkzWCt3UkdydVhI?=
 =?utf-8?B?WHFxNllrUTJ2V3orT0JSRXA5QUpYTm00bDdDV3NkU0lpejVlM2RWUmhrSk5h?=
 =?utf-8?B?WlNjbEl2WWsyNlhXYSsxaTJwTmxpVmJmV3ZyVU0rUzF5N2hUUG4zV0lCQzkr?=
 =?utf-8?B?VEs0bWVYVVB1RGZpTm11ZXpMblAwMzR6RUxyTnc0VEJaUjBtY09SS3c2RCtr?=
 =?utf-8?B?OTZzaE4vUHBqZWY4Z2YyTWlqMUE2VjUvL2xZZEs5TGtkUExlVG9kT1N4L1hG?=
 =?utf-8?B?TFBIdjUwVVkySzZURTJSZHd4YkE2eXZtekdrNm1KbmM3Ky9XVXV1Z0wyUlQ1?=
 =?utf-8?B?U0YwWGhha21DZUZJSUVpU3lnWkFleXVFc21PRjBhZTQ0c0NIRmdRMnZBS01L?=
 =?utf-8?B?azFGVEdZL1JFbWZ2MFlmUFB1RENYSklBQmNBN3FDdWtmQmt6ME5Ybi9zcmJB?=
 =?utf-8?B?SndGb1FORDBValhWVnhXc1ZsekdQYnZOVEhaeTRvd1lGc1BSYVc3UkhMcyts?=
 =?utf-8?B?a2h4MmgwSmlyVlZLb2VaYWlMNzR5eXFXSGh3TlQ2RkdVeVFrUzdSb20zNU5T?=
 =?utf-8?B?bDd3QkZRUVNyeDlRWUtVN3BLTnp4b3RMNXdFK2tyRlpYeFRISFFOUkdhenRY?=
 =?utf-8?B?Y2lFTmxsQWJidTZ4aVYySDk3MEpkRVdmOWlUMHFWeEZ5NVAzSGk1MGhBTlUr?=
 =?utf-8?Q?qMCFWMCjy8YmurORYJevqPA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWczRUVuY0ZEZTVaQUNON0hlWXFBc0l3SzVwV1JydCt4b1NPQzZPQm9ybjg0?=
 =?utf-8?B?ZXVqeEVJNTJFVDI0SVRheWhBNlc0MTgvMDhST3VDQnV2bEh6cjI0aWYrYTM3?=
 =?utf-8?B?OHQ0Y3BkWDBxeUI0MHgzTjg0K3NNaDhLbXJ5WUVrMnAyQll3RWxWaEh4NTFX?=
 =?utf-8?B?R2IwTEdOOWhVKy9aYmdUSzNmT2tDL1ZjMzZKOFp0aERDQ0V2cVV5UkFTeFRp?=
 =?utf-8?B?Rkx2ekNKY1RRLzZzZGVQL3p1SUtqM01Wak5xUGFLTklCd3lkYkthSTVlR1Jl?=
 =?utf-8?B?dVUzdUpsWGFuc1llOUF6YWlLZXBNRDFPdHRVWDdXQk9nT1B1U2ZKNkZvUUZq?=
 =?utf-8?B?OVl6NWM1VEZob0VRWDZtTmVIdGhpNGNUL1RVdGRia3FROEV4ZWxlN1NHYm9n?=
 =?utf-8?B?My82ak1Hck1ZYXdhYjhDbGVOWk9Tc0ZZbUo1QlpmbkpkR3ZjRytwOGJyRW9r?=
 =?utf-8?B?NlNnVUZ1dFlMbzhnak5Zd2EwZUw0aUc5ZEN3M1BmSEs3S0tuYWNpa29WVnp0?=
 =?utf-8?B?NXRtcHlPOWtoTG5rUkZ4NjhiV0p0ZmhRTXlyTnoxcWJvQTRTbTNWOEJDSFht?=
 =?utf-8?B?RVE4emVLc1VoR1BuRmM1aUcyVW9XRkdEbDdlY1dYTEJ2ZUtrUE5iU2pwbjU2?=
 =?utf-8?B?ZWdwR3BBWXlYMEVCbDFCOC91Ui9ZT0orRWxpMmpDd2orODlMaENueG81b1R3?=
 =?utf-8?B?N3VQTmQ0THBKczBqREpsRjFYY2JMWUtoTTZpRUpKTDVuMlRoemtmeWU3VHJ0?=
 =?utf-8?B?cWVEbmN3b3E4dEN3N1orMXdldlA2c1dSSTlyemlkbDF5SXpLc2Q5ZEEyM3Az?=
 =?utf-8?B?eXBOY3NDQjRBMGVGbDNjcmZvZGRkY2ZmTGdyWmlKM3kzNysyS1BkNGpNSkwr?=
 =?utf-8?B?Q2Jha2JuUGhnQ3JoNjh0WWNjYmhCZk5mUVVxNUZaZFVKaWluSDdyOXVBa0xy?=
 =?utf-8?B?Q1gwY0d1QzM1OFBJdCtIZEZwUnJXSVduK0ZJSEp4WHNCS0ZVTGdsS3ZFekNU?=
 =?utf-8?B?TlNjOURNQjZEaFdoTjQwSk5jTmhTTmw0MG01ZjRkbUtvTkJna2VVMTJUdUVK?=
 =?utf-8?B?KytEVTBzNXdQemt6bXpiSml3UmkwSG5tQkdVYS91ekprVGdVYTRvRUVrUmcy?=
 =?utf-8?B?Z252YmpSM09SbTFKQTNDZVU2Y3RZdDBSZUhBYzMxTnZ4c0dGNk9lcDV1ZnQr?=
 =?utf-8?B?c3FCQ1lseEZYbk5FSnV1bTExTHJHbXFFWU1FakVzVjh0NDVvNTFTckdMVTZt?=
 =?utf-8?B?WVFnRHBnMXE0SXlyWjQvME9ySDhiSWVVNjFyTWhSWVFkZlFHMHJYTncwRVFT?=
 =?utf-8?B?MnNaWUpjZzZTQ0x2UnpaUGduVlVCaVlzL2w4TDU1UlA2YzdkZ2dZVTV2M1dP?=
 =?utf-8?B?ZVlhSnpBMFI5OFNOeEJXSXprdWxEVi81V1BSQlpsS29wbnhTRjNDYXRaK0Ny?=
 =?utf-8?B?bUZ5dUdFUng4NzJsS3ppSzM5S1Z2QlUxbGI3Nm4vS2NFRFo4azZJSmVIcG43?=
 =?utf-8?B?eUZqUXJSZUpKNmpqZ1ZNUnVWVUh0QWJncUl5aC9VVXNwYkU2YS91RlpwdmpN?=
 =?utf-8?B?MTBJRFJ3RVlxaTJTWlIrSzdlM1ozZVFVTmwyY2VLeVJ3NHRMNmhQMG9aR0wv?=
 =?utf-8?B?RDMya0liK0RBUXhncTkvVXYrVGloc01vZDBDMWJheTNWaCtvRXpqVmdwRzZn?=
 =?utf-8?B?Ti93Q3NueXdjTkprc1lWZzNOMkVBNmJONStDcFFnY3oxRnJQb1BUOEV4aUNm?=
 =?utf-8?B?ZTdJSHhNQ2hUMGt4Wk84em90UmZaSkhlcmNhYlB3U21nMnh0WnVxV09ZL3Fn?=
 =?utf-8?B?U2VvSEswd2NtL0RFU2xZRVA1OXM5aFRzb0xMUTJVY25za3JsZGtJTHl2dXda?=
 =?utf-8?B?eTNUVEdob2ZWTXNCOERpNm0xczJpYStZVGJrcG1sU01tbWVTbVBtOGhKeExi?=
 =?utf-8?B?Q2JNeU9QMUJHQUQwZTZ2Z2s4QTV3YkRybERoNmNLbHJ0eDRjdmhST0c4bm5Z?=
 =?utf-8?B?ZE93ekZ1akJJSkRVRDNaNEVpZDllR2l2Z05ZUGpIenNLT3FKRC9Db0g5dWZX?=
 =?utf-8?B?VFdvRDlWenBGdjF6N1hlSk9FeWg4bkt5eFQ4VGo1RDhmQ2FRejdsY3NDN3M4?=
 =?utf-8?B?QmsvbkdHVHgwc0tPTTY3U0tKRktxUlg4dlVVUkRqT2RGTklHbGZITStzWEhs?=
 =?utf-8?B?RW9ReVZrNU5KTnJucWFQbTNxQ2ZDTjhiRlluMGplVE9QTFI1djEycURuVm1M?=
 =?utf-8?B?Rzd3UmZ6bkMvSExLL1F2TzVGU0x6RFN1eHlhQkFqcHg2VGcvZTIzQUxmWmxB?=
 =?utf-8?B?ZHBFcys4Tk9DTkdkMnJ6WjB0VXZJamJvWkVsK0xpRW9FZDhJTS9XZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b78593-e3ed-46fd-ef57-08de601343a9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 15:21:39.1607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAVuoV73GHSqQweEGq+WaX5dqfV7ViIAHVw3XqRoXyuOj/CCMFd0wGgVhnOeOCCYB1JnR2qVyYKXbz7ZlcF70Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9738
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
	TAGGED_FROM(0.00)[bounces-8618-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 4BCC2BBFC7
X-Rspamd-Action: no action

Use dmaengine_prep_submit() to simple code. No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index 2a0962a0b441754577c15ef3a67a7640d41785cc..c9ad4c3a5c15e046d9e66050dcfd8a9379bf60df 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -720,7 +720,6 @@ static void lpi2c_dma_callback(void *data)
 
 static int lpi2c_dma_rx_cmd_submit(struct lpi2c_imx_struct *lpi2c_imx)
 {
-	struct dma_async_tx_descriptor *rx_cmd_desc;
 	struct lpi2c_imx_dma *dma = lpi2c_imx->dma;
 	struct dma_chan *txchan = dma->chan_tx;
 	dma_cookie_t cookie;
@@ -733,15 +732,10 @@ static int lpi2c_dma_rx_cmd_submit(struct lpi2c_imx_struct *lpi2c_imx)
 		return -EINVAL;
 	}
 
-	rx_cmd_desc = dmaengine_prep_slave_single(txchan, dma->dma_tx_addr,
-						  dma->rx_cmd_buf_len, DMA_MEM_TO_DEV,
-						  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-	if (!rx_cmd_desc) {
-		dev_err(&lpi2c_imx->adapter.dev, "DMA prep slave sg failed, use pio\n");
-		goto desc_prepare_err_exit;
-	}
-
-	cookie = dmaengine_submit(rx_cmd_desc);
+	cookie = dmaengine_prep_submit(txchan, NULL, NULL, slave_single,
+				       dma->dma_tx_addr,
+				       dma->rx_cmd_buf_len, DMA_MEM_TO_DEV,
+				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (dma_submit_error(cookie)) {
 		dev_err(&lpi2c_imx->adapter.dev, "submitting DMA failed, use pio\n");
 		goto submit_err_exit;
@@ -751,15 +745,9 @@ static int lpi2c_dma_rx_cmd_submit(struct lpi2c_imx_struct *lpi2c_imx)
 
 	return 0;
 
-desc_prepare_err_exit:
-	dma_unmap_single(txchan->device->dev, dma->dma_tx_addr,
-			 dma->rx_cmd_buf_len, DMA_TO_DEVICE);
-	return -EINVAL;
-
 submit_err_exit:
 	dma_unmap_single(txchan->device->dev, dma->dma_tx_addr,
 			 dma->rx_cmd_buf_len, DMA_TO_DEVICE);
-	dmaengine_desc_free(rx_cmd_desc);
 	return -EINVAL;
 }
 

-- 
2.34.1


