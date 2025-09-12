Return-Path: <dmaengine+bounces-6485-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F36B54A71
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 12:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A6EB3B199B
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 10:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D044F2EB5B0;
	Fri, 12 Sep 2025 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TxQUBMwx"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011055.outbound.protection.outlook.com [40.107.130.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F28E20E023;
	Fri, 12 Sep 2025 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674570; cv=fail; b=sjoAoe6YAMZvLFwNSLXuoLrhamcWBOR4YRg82jU5ZmM49vcAHWrmbQQvas5kyHyZnqr/logSojb2lEryYUpf+N5u0LDje7LM+pe7OUiIEUkpkCewPPAGuD9lVvbRcRbrzwrSLxSYU7Gdsygxc4wROd0d1bM96Yc4rAkNknY1BTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674570; c=relaxed/simple;
	bh=4CGLei4LrJmq5cqziimykO1xiEuV5LgNtFm0w47XEc8=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=kqVim/wjv0rXqYmz4Bug2GjPcufINvHosfe/y5At//O3zGWikUAPUpEnC3crXSSwIUNOIghVw8VouFEsu1Lwny6WDApM8dB25tVSpKFr0uJvpbmjo4fGMIcI13YsSw+/DT/iwSXxBe1RYOf+6OZGipvvjwDlW8FQJwUUQhsolgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TxQUBMwx; arc=fail smtp.client-ip=40.107.130.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GY0bZwZcvL93wr5iGkvkALVtlmezF6Hthl4cxzYpuzA14VP992AhYm/a7YHp6yEUWKs8IeqI0J8ouF5zAx4Oo3tIcjtM3vP0VSIwNcVBOoTGDf5cvYBuxUxqzYx41BY7KOdVusOpTpznW8Lu69oF2SnyEZSJkk52c8MEab7ZXN7sugWqXgUl9PbeQRrJdkmes6INmsSE0xPQjUAbi9V3YNgXuIaUH7hoJVQ8k/JfTfA4VjfgzYt0M8Yp+xbPwRG0yBcFkN0KTRg/tasUFZ5njSfz6K/2CR5pDhV9oUphW1kh5fWuY9jvFWntf/71W564qa+kKXfGf4AkCqZfxp2n3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugcVWvkceNU7I2m3I+pQaEezh0AeAcbLVxp1TkqnQok=;
 b=J/Ba+XH+vNSUXRosCenPUAo7CvhmeVgbP3XQCghIVZ29nN7C6Ymm5ZAnW62YG11hEELvdML3fcBMDg72NGaRCqUMQjLFhv4zha1adZsjytSX0H44il7zCydKK3eemhYCULApItwiWAFgfNi+znM0aSz9B+BP+cYf5vr20W6FzXf/2Mgxe2bFIyV8Fu8aJWgUcGrgvr/tc4cI3nFvhICvoqbECZBUcX/F+itYCkAZ6dUXwtL+sE6inQ3nN5gbmPTHyPkE2yulIiXPE/5R4HUddkxbG6XolHScHb3Az0ZXYa+hFh50SAxQ1d1OnaXfJyIRyeXI9q7xjUKh7cCmRo3UAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugcVWvkceNU7I2m3I+pQaEezh0AeAcbLVxp1TkqnQok=;
 b=TxQUBMwxanIYqFqYumf9lE+LWIG+LS/qq9ych7PMEpknbtnNYni7m70zODxVjB4u2bCG/2Ulpfgbk6hN8zznSLsu40gd3oSGieRPOsSYC1n7LhEpTcFJRTwglsMksU+Ap+aT81oQzvrLoVmE259nttiMooO3vTXpRnkp5GXmInyDy6zW0CzJcX+6ys2X9JVDsOgaGpNoQOYDvsb2VjMZFg9vAV5FwtAvaRrEn3rGcPU8C80uKmfntQ72jVGTNUGAohgEyjARvDvHGnof90BbA8r5KaubTStqGzgAm9DsBI8Yx/18M8O022ZsShScPG0/BkRH4PG/u1z0lvJav6W8Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com (2603:10a6:10:36b::13)
 by VI1PR04MB9739.eurprd04.prod.outlook.com (2603:10a6:800:1df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Fri, 12 Sep
 2025 10:56:04 +0000
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::8737:4de3:41e0:b516]) by DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::8737:4de3:41e0:b516%7]) with mapi id 15.20.9115.010; Fri, 12 Sep 2025
 10:56:03 +0000
From: Joy Zou <joy.zou@nxp.com>
Date: Fri, 12 Sep 2025 18:55:42 +0800
Subject: [PATCH v3] dmaegnine: fsl-edma: add runtime suspend/resume support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-b4-edma-runtime-v3-1-be22f7161745@nxp.com>
X-B4-Tracking: v=1; b=H4sIAC38w2gC/4WNsQ6DIBRFf8UwSwMPKNip/9F0QIGWQTRgiY3x3
 4sO7dQ4npuccxeUbPQ2oUu1oGizT34IBVhdoe6pw8NibwojICBIQwG3HFvTaxxfYfK9xcCc5Fw
 TAbJFxRqjdX7ei7d74adP0xDf+0Gm2/q/lSmmuFGSOyOFohSuYR5P3dCjrZTZgc2KbYhUjYGOa
 tF+7bo6sMBwzZ1iZ8Lc73Nd1w9DFqyiIAEAAA==
X-Change-ID: 20250912-b4-edma-runtime-23f744a0527b
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To DB9PR04MB9377.eurprd04.prod.outlook.com (2603:10a6:10:36b::13)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9377:EE_|VI1PR04MB9739:EE_
X-MS-Office365-Filtering-Correlation-Id: b833276e-2182-431f-a269-08ddf1eaf7a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzlRQUl2ZE9xWWFkTDB4S2JQanNEaFBhZlhYWnJjU1dORk5ZUzl2cVFKQWQw?=
 =?utf-8?B?c084aXAwMTZGNGFrVjJxMmpUbGRZejlteFpsdmRFZVY1cStKNFY2ekVvMHRZ?=
 =?utf-8?B?OStnSnVDTlRyZnhXMitCNWNmNXFnYlN6R1ZPbGg5aVhpcy9GeXQwMGtOTE4z?=
 =?utf-8?B?N0Y2YldQTWE1Y3cxbnpzSGlONHlwYWVvQ3R1Ylk4a2xHY3VHUkQ1L2RvQzl0?=
 =?utf-8?B?R1pCMVpZVUIvTFNTSjkwR0wxTVY4ZDR0UHZncnNPUkpMbVZEalpwVHV3WTdk?=
 =?utf-8?B?WitPNWFna1p3QzlkOUQrUVBCNzZkVktjYnN2NlpYT3U4K1U5Mng3QjJNc2dm?=
 =?utf-8?B?bnV5czBISWI1aEVObzRudFZFOW9JWFRjQXk4N25UbSt0SkZOV29MaWh4TTV4?=
 =?utf-8?B?ZDhDeGdXcjJtaFBWUE9JNXpJek1FTG5yZVgzbmlhbzJraXdUN0JRTUVoYXBa?=
 =?utf-8?B?c2V4MFpGOWJhQ01oS0praUI2WDgxc3UyR0dEUGMrMENKZ1Iwc2dFOVNMRU5t?=
 =?utf-8?B?U0VkR3dOMzlaT1B2dXhCNzVyRHVrUE85OVAvcWFqQWViZngzNVZOK2RJZnBx?=
 =?utf-8?B?OThDRExud3NjU09TV2QxQ2Q3UkFOZUtDdEtuZ0Z5YzhrZE5mQkcrRHlQN1Uw?=
 =?utf-8?B?N2JGNTBCUWIyUExPeU5ndjQxdnRtQUZ6VmF6cGNtTXVrQXhnTmdxaWVvcm5C?=
 =?utf-8?B?Mk1HT0hZS0NNWGtvTUR6NmsyM05rOFNWUTd1Y2V0TytVTmF5Y1QxV1RDbVI2?=
 =?utf-8?B?d0l1L3p5RVVRVG9lTi9wWHAzTlJqYmpRNkZhcE1ycFdpQ0hGZnJhdjhhK0g4?=
 =?utf-8?B?WUVEYzEvUmtoTThmUlhUZDRXM3o2NnNHaDVvS3BoaVdqZFY1Qi9xM0lmbGtz?=
 =?utf-8?B?bkZid2ZzRTVuMXBHVmx1Q3VTNDN3ZDJwNno5VW9yeGpoWEsvUU9WdlNNZ0R5?=
 =?utf-8?B?aVYxQmVDV2FPSERkVEdBbEVDdC9ydndHc3dnM0FkK3NuZ0VZc2ZpL3kyY0w4?=
 =?utf-8?B?QVpaRkNwSkxNaHVzTXFWMFNzNmxDZ1EybktCTkIwUDAwdlZYVEZQK0oyb24w?=
 =?utf-8?B?Zk5PSDFLSEZFYXRBa2dyRHk1NFQ0ZVF3RjFrYS9TaHhFdWh3Z3Z3dVlrUjVP?=
 =?utf-8?B?Yk00K1k0WUFoaFpLNVVTSnpackdxanRMeXJoS25PS1prY2hzRHdxS20wd3g0?=
 =?utf-8?B?NWFTeDBOL0FWK3c4djU0a2I5cEVqSlNlaG1HRGVYVzkzVkZVSVhUWEFQQUw5?=
 =?utf-8?B?Uk5zMVhFK3R0MjlzK0g4bUNzbUlKSjhKdFNyMG0xL3p2NjRUUnF2NmdMaC9R?=
 =?utf-8?B?STJMTmtPTE1TOUhPRzNtSlIxU0krU0srYVJ2TG90bTJWeENEd0YzNTdJL0s5?=
 =?utf-8?B?S0VYeSttTnp5T2IrbytDa3J6dDlRenVhLzlsaDd0TTNyTzdhWEtjcmhJQ2I2?=
 =?utf-8?B?N0JMY1k0SEhsUHBkeThBRFBIcm9tOVdxektuMXBvU3l4amc1Z3d1YlpBanNH?=
 =?utf-8?B?ZDB1NEtUc2ZOVHVNZEsrTTJJYzEwSzk1eExwbDlqc3JPdE9lS0ZEOG0wS0to?=
 =?utf-8?B?R1czbXN2YzYyQ2dvRlNDMDdYaVBXR24zUzZoOXhwelRZbDY0QndLazBZNU9Q?=
 =?utf-8?B?bFF6QUc4U1JWVnYxL0ErWHNRRnB1MWRlSkRWN0tHTmZNNi8xc0JGdWlqdkJx?=
 =?utf-8?B?VnZ6SFViYkZZeUNyVWRRcDQ1K3k0djVYK0VJL3FHU2RrMHY1MEtXTlBYMmJv?=
 =?utf-8?B?cE9WbFB6RUYzazlVVmFiL3BtdHdUdC80b2ZtR2xYWmsxZkZxWnBFczJsakFE?=
 =?utf-8?B?QXpEMWlSV29pK2FYWUNMZWdmbHFWZnlGbm5CL2I0bTZKTEZZaUU0N3JnOFV4?=
 =?utf-8?B?TUYyOWM0NXRsT1cxYnhxaGx2dEZOMWlPZnUvRFBkT1l6amtST3h6NHZLMWdJ?=
 =?utf-8?B?V1krZVYybjdLNysyVE9KMkgyVGNYd29WZ0JoT0Npcmh3VmlwaHV1Z0M0Wjho?=
 =?utf-8?Q?FKBl5XhGsd+I/Cm+0foBsv+tG3GC9I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9377.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YldBOWFhaWpRc2dXM3cvYWZNK1g5SkV3dVBKZ0hEZ1FOY24xdEtvQkpudmVI?=
 =?utf-8?B?R0gyZnhLTFFmdDNtMEZnVXhYNDRyNHp2NHluSlRBMEkrazU1VHJkM0NhZXJS?=
 =?utf-8?B?RnlMYzZuUmJHczdjUWp2bGloYTA3bVkvd0VnT3JBM3JKTUVEUFM0MWV4bVZN?=
 =?utf-8?B?VUhzSkEwN1NYMGFyV2NJVldBMEYzUkpJdzJlTlc0S0xpMUp2QmIzaFVZV0RX?=
 =?utf-8?B?OXYzZENveVh5NU83MGJac2NEemFVK2R6RWJTMjMyTUlFOTlWMkdSbW1hYmhL?=
 =?utf-8?B?RjYrMFhvWHNFRTZjakhwS0JUMG1EL2NZMVBsNURiZnUvV3FDRTNycnZ2TmVj?=
 =?utf-8?B?NjRZSG80Unlxdmg3b1JqZ1JiYXRnQWVmL1B6eHVNUlJ3Z3FpQnphWW4zdGt5?=
 =?utf-8?B?Z21SQTBZSUk0RnFvWjYxMW45Tkp2T09uR3d0VzdJV0F1R2g2YnBWdGZ6RDVC?=
 =?utf-8?B?RWNLWStpenVpRWc3dkpCQzNGazBtMFlZRm1sQzRPMjdTUVdrdzJYZXJobktT?=
 =?utf-8?B?a0dhRnlzZ2hLWTRjcFZ3c05Ja0ZuU3BXYnFjQ3U1cDg2V012RWdBa2I0elAy?=
 =?utf-8?B?OHVKRzFuUlh1N0ZmbGhXeWliRklOVkJHamI0dmNqZDNzZWxWWnNkeXZDODZD?=
 =?utf-8?B?enB6a1kwUXZNU1RtQjdTOXRKQ0dwMXVnOVpab2g4RStyOVIrd2NzOTlmUGE0?=
 =?utf-8?B?S3NRQ0NkOWZSam5HSHk0NDVURXJLQkxhT0wvTlpLWkZWRkxGMVpUOHYrT1Az?=
 =?utf-8?B?ZTc3QkJpWE5mdGtwNHovejdtU3hkN0dPbHVWekR2RklPYXJXelFLQk1OSDI1?=
 =?utf-8?B?ZEpxUnFDYzBhN0RCVVB3QWlwTG9yV3YxOEo3eTJ6NVJYL21jczk1cFI4Uk90?=
 =?utf-8?B?Z2Uyd0toMmFoZmdVcXZ5YVhFYSt0b0ZCZWUxMFpESnk4dmJJdFNJbWdPdlpQ?=
 =?utf-8?B?WVZoekJCWkxJbDRXYmdjMFRqM01MaHVFM3dsWDd6VUlYYWJIaTV6Q0VzSkRm?=
 =?utf-8?B?cDRmakljWDJoSGVzUDZJdHBtV1h3SW5heUpIaXBoME9TcmU3Z2c5L2lFeEV4?=
 =?utf-8?B?REVXQzVXNHYvRWw3bytLbnR3bXREMUpOTjNIdmNNcGE0T3VwQk9LamFtRVAv?=
 =?utf-8?B?S1NOYTVZeWFzMDZ6SC9ibTlTc0lFUEY1Zm1GOWZMSDN4OUtobDZEQWI3MExM?=
 =?utf-8?B?ak83dDY1R1BFTyt4dytDTHlaMnNmeXpFV0phTXJvYWFtS2RURW9XbEwzUWlQ?=
 =?utf-8?B?SEdxRm9GVzlsT3MzQ1BqbDVBeXRncCtTMEJDem9xQ0pJUDBMdEE2S04rMGlr?=
 =?utf-8?B?RGVHYThuTCtwRWptRCtrV29zVVlNSGpVY2NYeDVMc0MzcFZNRzMra2dzV0li?=
 =?utf-8?B?NzUyQ2g5SVhPSnJoRWdkekdIb1Q2c2wyMERtRjFRbXYrcXNkYlNtSmE4Snp1?=
 =?utf-8?B?dFdQZ3VVaXRWRWtUaGd2c1hjOWIyZ3BjekkwTnZxTGxsK2Rhb3Z2RUN5V0lF?=
 =?utf-8?B?QnhGazJDRGdUemVTQ2l6dytwZExOMEFmcVc0TmNBczJXWGNHV29YYTNvOU5x?=
 =?utf-8?B?S2VmdUpmWHVWRnFpODJaUDd6QUR4aklTZ1M1K0FjQk54ZGlhTjNTSzRCaUdS?=
 =?utf-8?B?azEzVXdwODc5ZG5iRmRWdVVyZzJJMTFMOC85WC9LT1pGdVlHZzlkVXJRYkZ6?=
 =?utf-8?B?eTZ0cXdLY3piU1MwY3BCbld2cFdnVjd4SW9ZWXZiTEw3YTBwMkR3NUdhaUNo?=
 =?utf-8?B?OG1ZZ2JDTHJGQ2NsK1FjbWVMeTEzYWl5Tm4wOTV0SEswVjlVeHVqaDFuSFFR?=
 =?utf-8?B?SDZwNjJ0OVYzU25LeHdDemFvN0RXTGhkNHNiSDdaZU5sVWVseEZGUURNSGlr?=
 =?utf-8?B?VkRVYmpJOWpoL3JRb1kxV1B0QWc2aCsvSlBaOEh3YUJRd1B1dWpTZU9KU09P?=
 =?utf-8?B?SFNmZWNkaWZIY0RXUlI5amxBYk5LNitWMFJIYXVqZ2p2eWRsdFBGUnFVUzBE?=
 =?utf-8?B?UEhHdFJHdWZqaS9EMkFPQXZpalFLS2l1blpBc0t3cXJiR2oxNFBzNDdHQjc5?=
 =?utf-8?B?aVMzRlc0T3JKU2czUkxTb1FSQnRKb1ZJWkx1bzNhMmprSXQyRGtvR2xndXNF?=
 =?utf-8?Q?b/pp7LjBOXG2vbYpRAhX03gD2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b833276e-2182-431f-a269-08ddf1eaf7a2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9377.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:56:03.7668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5V1SnUJU0ldAPcxnEg8EpzGey+8d9BOIRmY1u8MELuv5nqpSoeDId5cVXGiCrXG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9739

Introduce runtime suspend and resume support for FSL eDMA. Enable
per-channel power domain management to facilitate runtime suspend and
resume operations.

Implement runtime suspend and resume functions for the eDMA engine and
individual channels.

Link per-channel power domain device to eDMA per-channel device instead of
eDMA engine device. So Power Manage framework manage power state of linked
domain device when per-channel device request runtime resume/suspend.

Trigger the eDMA engine's runtime suspend when all channels are suspended,
disabling all common clocks through the runtime PM framework.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes for V3:
- rebased onto commit 8f21d9da4670 ("Add linux-next specific files for 20250911")
  to align with latest changes.
- Remove pm_runtime_dont_use_autosuspend() from fsl_edma3_detach_pd().
  because the autosuspend is not used.
- Move some edma channel registers initialization after the chan_dev
  pm_runtime_enable().
- Add clk_prepare_enable() return check in fsl_edma_runtime_resume.
- Add flag FSL_EDMA_DRV_HAS_DMACLK check in fsl_edma_runtime_resume/suspend().
- Link to v2: https://lore.kernel.org/imx/20241226052643.1951886-1-joy.zou@nxp.com/

Changes for V2:
- drop ret from fsl_edma_chan_runtime_suspend().
- drop ret from fsl_edma_chan_runtime_resume() and return clk_prepare_enable().
- add review tag
- Link to v1: https://lore.kernel.org/imx/20241220021109.2102294-1-joy.zou@nxp.com/
---
Changes in v4:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v3: https://lore.kernel.org/r/20250912-b4-edma-runtime-v3-1-2d4a4f83603f@nxp.com
---
 drivers/dma/fsl-edma-common.c |  15 ++---
 drivers/dma/fsl-edma-main.c   | 129 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 116 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 4976d7dde08090d16277af4b9f784b9745485320..55cb094088d569b87cde78a36734a1fc7e251b73 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -243,9 +243,6 @@ int fsl_edma_terminate_all(struct dma_chan *chan)
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
 
-	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_PD)
-		pm_runtime_allow(fsl_chan->pd_dev);
-
 	return 0;
 }
 
@@ -823,8 +820,12 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
 	int ret = 0;
 
-	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
-		clk_prepare_enable(fsl_chan->clk);
+	ret = pm_runtime_get_sync(&fsl_chan->vchan.chan.dev->device);
+	if (ret < 0) {
+		dev_err(&fsl_chan->vchan.chan.dev->device, "pm_runtime_get_sync() failed\n");
+		pm_runtime_disable(&fsl_chan->vchan.chan.dev->device);
+		return ret;
+	}
 
 	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", chan->device->dev,
 				fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_TCD64 ?
@@ -852,6 +853,7 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 		free_irq(fsl_chan->txirq, fsl_chan);
 err_txirq:
 	dma_pool_destroy(fsl_chan->tcd_pool);
+	pm_runtime_put_sync_suspend(&fsl_chan->vchan.chan.dev->device);
 
 	return ret;
 }
@@ -883,8 +885,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 	fsl_chan->is_sw = false;
 	fsl_chan->srcid = 0;
 	fsl_chan->is_remote = false;
-	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
-		clk_disable_unprepare(fsl_chan->clk);
+	pm_runtime_put_sync_suspend(&fsl_chan->vchan.chan.dev->device);
 }
 
 void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 97583c7d51a2e8e7a50c7eb4f5ff0582ac95798d..e06f4240fdeb8839493f00c63b640eb3aa795b91 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -642,7 +642,6 @@ static void fsl_edma3_detach_pd(struct fsl_edma_engine *fsl_edma)
 			device_link_del(fsl_chan->pd_dev_link);
 		if (fsl_chan->pd_dev) {
 			dev_pm_domain_detach(fsl_chan->pd_dev, false);
-			pm_runtime_dont_use_autosuspend(fsl_chan->pd_dev);
 			pm_runtime_set_suspended(fsl_chan->pd_dev);
 		}
 	}
@@ -673,23 +672,8 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
 			dev_err(dev, "Failed attach pd %d\n", i);
 			goto detach;
 		}
-
-		fsl_chan->pd_dev_link = device_link_add(dev, pd_chan, DL_FLAG_STATELESS |
-					     DL_FLAG_PM_RUNTIME |
-					     DL_FLAG_RPM_ACTIVE);
-		if (!fsl_chan->pd_dev_link) {
-			dev_err(dev, "Failed to add device_link to %d\n", i);
-			dev_pm_domain_detach(pd_chan, false);
-			goto detach;
-		}
-
 		fsl_chan->pd_dev = pd_chan;
-
-		pm_runtime_use_autosuspend(fsl_chan->pd_dev);
-		pm_runtime_set_autosuspend_delay(fsl_chan->pd_dev, 200);
-		pm_runtime_set_active(fsl_chan->pd_dev);
 	}
-
 	return 0;
 
 detach:
@@ -697,6 +681,29 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
 	return -EINVAL;
 }
 
+/* Per channel dma power domain */
+static int fsl_edma_chan_runtime_suspend(struct device *dev)
+{
+	struct fsl_edma_chan *fsl_chan = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(fsl_chan->clk);
+
+	return 0;
+}
+
+static int fsl_edma_chan_runtime_resume(struct device *dev)
+{
+	struct fsl_edma_chan *fsl_chan = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(fsl_chan->clk);
+}
+
+static struct dev_pm_domain fsl_edma_chan_pm_domain = {
+	.ops = {
+	       RUNTIME_PM_OPS(fsl_edma_chan_runtime_suspend, fsl_edma_chan_runtime_resume, NULL)
+	}
+};
+
 static int fsl_edma_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -826,11 +833,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		}
 		fsl_chan->pdev = pdev;
 		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
-
-		edma_write_tcdreg(fsl_chan, cpu_to_le32(0), csr);
-		fsl_edma_chan_mux(fsl_chan, 0, false);
-		if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_HAS_CHCLK)
-			clk_disable_unprepare(fsl_chan->clk);
 	}
 
 	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
@@ -889,6 +891,45 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	pm_runtime_enable(&pdev->dev);
+
+	for (i = 0; i < fsl_edma->n_chans; i++) {
+		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
+		struct device *chan_dev;
+
+		if (fsl_edma->chan_masked & BIT(i))
+			continue;
+
+		chan_dev = &fsl_chan->vchan.chan.dev->device;
+		dev_set_drvdata(chan_dev, fsl_chan);
+		dev_pm_domain_set(chan_dev, &fsl_edma_chan_pm_domain);
+
+		if (fsl_chan->pd_dev) {
+			fsl_chan->pd_dev_link = device_link_add(chan_dev, fsl_chan->pd_dev,
+								DL_FLAG_STATELESS |
+								DL_FLAG_PM_RUNTIME |
+								DL_FLAG_RPM_ACTIVE);
+			if (!fsl_chan->pd_dev_link) {
+				dev_pm_domain_detach(fsl_chan->pd_dev, false);
+				fsl_edma3_detach_pd(fsl_edma);
+				return dev_err_probe(&pdev->dev, -EINVAL,
+						     "Failed to add device_link to %d\n", i);
+			}
+			pm_runtime_put_sync_suspend(fsl_chan->pd_dev);
+		}
+		pm_runtime_enable(chan_dev);
+
+		if (fsl_chan->pd_dev)
+			pm_runtime_get_sync(fsl_chan->pd_dev);
+
+		edma_write_tcdreg(fsl_chan, cpu_to_le32(0), csr);
+		fsl_edma_chan_mux(fsl_chan, 0, false);
+		if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_HAS_CHCLK)
+			clk_disable_unprepare(fsl_chan->clk);
+		if (fsl_chan->pd_dev)
+			pm_runtime_put_sync_suspend(fsl_chan->pd_dev);
+	}
+
 	ret = of_dma_controller_register(np,
 			drvdata->dmamuxs ? fsl_edma_xlate : fsl_edma3_xlate,
 			fsl_edma);
@@ -929,6 +970,13 @@ static int fsl_edma_suspend_late(struct device *dev)
 		fsl_chan = &fsl_edma->chans[i];
 		if (fsl_edma->chan_masked & BIT(i))
 			continue;
+
+		if (pm_runtime_status_suspended(&fsl_chan->vchan.chan.dev->device) ||
+		    (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_HAS_PD) &&
+		     (fsl_edma->drvdata->flags & FSL_EDMA_DRV_SPLIT_REG) &&
+		     !fsl_chan->srcid))
+			continue;
+
 		spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
 		/* Make sure chan is idle or will force disable. */
 		if (unlikely(fsl_chan->status == DMA_IN_PROGRESS)) {
@@ -955,6 +1003,13 @@ static int fsl_edma_resume_early(struct device *dev)
 		fsl_chan = &fsl_edma->chans[i];
 		if (fsl_edma->chan_masked & BIT(i))
 			continue;
+
+		if (pm_runtime_status_suspended(&fsl_chan->vchan.chan.dev->device) ||
+		    (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_HAS_PD) &&
+		     (fsl_edma->drvdata->flags & FSL_EDMA_DRV_SPLIT_REG) &&
+		     !fsl_chan->srcid))
+			continue;
+
 		fsl_chan->pm_state = RUNNING;
 		edma_write_tcdreg(fsl_chan, 0, csr);
 		if (fsl_chan->srcid != 0)
@@ -967,6 +1022,37 @@ static int fsl_edma_resume_early(struct device *dev)
 	return 0;
 }
 
+/* edma engine runtime system/resume */
+static int fsl_edma_runtime_suspend(struct device *dev)
+{
+	struct fsl_edma_engine *fsl_edma = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++)
+		clk_disable_unprepare(fsl_edma->muxclk[i]);
+
+	if (fsl_edma->drvdata->flags & FSL_EDMA_DRV_HAS_DMACLK)
+		clk_disable_unprepare(fsl_edma->dmaclk);
+
+	return 0;
+}
+
+static int fsl_edma_runtime_resume(struct device *dev)
+{
+	struct fsl_edma_engine *fsl_edma = dev_get_drvdata(dev);
+	int i, ret;
+
+	for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++) {
+		ret = clk_prepare_enable(fsl_edma->muxclk[i]);
+		if (ret)
+			return ret;
+	}
+
+	if (fsl_edma->drvdata->flags & FSL_EDMA_DRV_HAS_DMACLK)
+		return clk_prepare_enable(fsl_edma->dmaclk);
+	return 0;
+}
+
 /*
  * eDMA provides the service to others, so it should be suspend late
  * and resume early. When eDMA suspend, all of the clients should stop
@@ -975,6 +1061,7 @@ static int fsl_edma_resume_early(struct device *dev)
 static const struct dev_pm_ops fsl_edma_pm_ops = {
 	.suspend_late   = fsl_edma_suspend_late,
 	.resume_early   = fsl_edma_resume_early,
+	 RUNTIME_PM_OPS(fsl_edma_runtime_suspend, fsl_edma_runtime_resume, NULL)
 };
 
 static struct platform_driver fsl_edma_driver = {

---
base-commit: 8f21d9da46702c4d6951ba60ca8a05f42870fe8f
change-id: 20250912-b4-edma-runtime-23f744a0527b

Best regards,
-- 
Joy Zou <joy.zou@nxp.com>


