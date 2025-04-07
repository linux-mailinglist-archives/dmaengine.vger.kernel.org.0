Return-Path: <dmaengine+bounces-4842-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A89A7E74E
	for <lists+dmaengine@lfdr.de>; Mon,  7 Apr 2025 18:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B33C1891253
	for <lists+dmaengine@lfdr.de>; Mon,  7 Apr 2025 16:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4BE2139BC;
	Mon,  7 Apr 2025 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nGF9R9O0"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2041.outbound.protection.outlook.com [40.107.103.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD072135A2;
	Mon,  7 Apr 2025 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744044419; cv=fail; b=o+CNqlH21isuqrZNqOVcTO+vG9oK72glPTceaSeWgT5nivkmhVSUt9Thv6CoydJdUA+RgYjiZM1kVSQF9tRjM4rnP++2PuoDre1GldtPP8G1ZqcCmdWW9JAQwwWS1MAiYrb5w+9OjGKBV+qvv/luTJd53NCAqOW9/7/G+RJrqAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744044419; c=relaxed/simple;
	bh=UV/EyvqxCJkl3WjDyAgtDWOSWyokir58QZg0tmiUxh4=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=J14YbEFqvp8DgwP2fwkUtMHfQNkO7GVvzE1kJmGBCqU+oXa1rNEDC7D9JgxkDtSJX7VUqtS+vXBy1kbCaxtFqB0yMzzR57q5Es+Ry8IAMItYVBujg/VuMksbagRmO1NyRdQUtB00O6pZ33gSXitJNhq5ibIR4pisnzfGzrO7bC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nGF9R9O0; arc=fail smtp.client-ip=40.107.103.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXLX9dyM/lhmt9fBRZufk8izy4Yi6I2t/XJmaEonVua3RlmprvP+uT1jbrrILIYFdz9Wdl3mDSrvKzruxXpnDhq+Bj4OnH625IJjttZ/nz/32iTQiHCzv/ftrcRyrMvu/yK8DiBY0l2Tp8SlkPo+a25tfMjSvBNvPPpfRHKQ0XjkH9qvgQ8BVw4a2QE1+/Lz7lxj/FVXXT7hPCS/5HP0nYyyLceF6LYrkcX67UKRH8T65v5jieg15reGRiNcKNu6kpga+++UqbUVV4Q5jYXkmkWjpL74KX0D+ISg7N58TfM83TfZVZ0MPFRrtcCUSyVVaOa5YugxfbmxuNLDPN36/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHU0TiDXccQqF6OC61H82VuWUMk3B6ibzXusIw1YZyU=;
 b=S8cHDrlIK0cTHdcGli+jvNDmTutgsg5R525o1kKMmI2Huy2gAfduGmDdnDwHy96wI04ww1Op/rYK+av9HbVA3cfdNiuxZLUUJn7+2GWIphxMjoDW9EKC6Lsit4C/JL2ku/GEDRXQPVWoNvtcXuHJtgfzvb0xVr55B2h90gyfFbZQxo94OHIg2C7wd2tyAfHwIZxDMQaa5aIc8oZv4Tbs7U4tpImiO5C6LDhsnIrXkysB4GcKSzlR0CzvyTX7UK1HW3XLPgVinrUUYlLjcA8Ns/gB25nHTVRkMRDZ2FrvG0x20/vWO35NB3PCQbU8iaQ6Mgs0RTY65D+DrQlDahzHeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHU0TiDXccQqF6OC61H82VuWUMk3B6ibzXusIw1YZyU=;
 b=nGF9R9O0CLnTNDTEwNUlkxtWH2nQfrZMI7qrhQsAyZxAGlPC8cDoreTEGCukz6IwuvUijwuPnmoz/I8WIJOXAstj84hRpjhvFQkjBFZG5/QO163IdJ/mU0RMNB2b5jMiNcjOOj+678bPVBFxgky6fZPBAfhGNZowDbHnUUKWNSXxpOeNGxwvYKiMfPjnqws9De8ISgnCTGiYHZhYz1vHZkVXiLr9bg5NZxh+mDJPt8BtYEOCOY3579ZmaJUqdnB22W5eMgZHP13nak6KLJlPQ74/9WXThw1KZej26fWT9s2Abab0hHLtJmkYcjCuLxk8F6CCpZDaVIlKhtYWM1lvVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7029.eurprd04.prod.outlook.com (2603:10a6:20b:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 16:46:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 16:46:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/3] dmaengine: fsl-edma: add error irq to help debug
 problem
Date: Mon, 07 Apr 2025 12:46:34 -0400
Message-Id: <20250407-edma_err-v2-0-9d7e5b77fcc4@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGoB9GcC/0XMQQqDMBCF4avIrJuSRGNTV71HkRLMWGdhlEkJF
 sndmwqly//x+HaIyIQRumoHxkSRllBCnyoYJheeKMiXBi21kVobgX52D2QWxl1qa7AxVkoo95V
 xpO2g7n3pieJr4fchJ/Vdf4j9I0kJKbyy7XXERrU13sK2nodlhj7n/AEeV8HingAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744044406; l=1112;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=UV/EyvqxCJkl3WjDyAgtDWOSWyokir58QZg0tmiUxh4=;
 b=0IQRdk6y8s7UMXYAY6shXJsPcBPJpeT4eNijxzQyMz0S/cGT98tH2DHYswbzncOOQTnTpFi9K
 rJR6YmKmN9DCFKs1zD7mclW2tlx83FI8DMlSTMwDUlo4QsKne0FJ5XO
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
X-MS-Office365-Filtering-Correlation-Id: 7d461a72-0b28-4563-7a86-08dd75f3cc7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVpMbzZYN1pjZVByOXhrc0wyaVh6QURXbW1VNTFhYnoybzFSMThsdGNWZ1ox?=
 =?utf-8?B?bHlLNWRvVEFyZ2FQdTNqcjNaaGswaERibjdCU0hRT24vc1FtNE5xR0ZnbDND?=
 =?utf-8?B?THJTWXVUbUtIeUZpbDA1eU9VWXFQQTRyYjV2aGc0b3NLWFdqeEdLcGNWQTdN?=
 =?utf-8?B?cnlGY3lzQS9WOG1LT2xrUjVrTmhhRysySWw3ZlppdFBJUWY0VkVnNS9IYXJl?=
 =?utf-8?B?bU90QUNjL1A4Q1p1ek5ONDZWN2U0ZTBBUzZwdE0xWG41Uk1oRzhWQ2N4eCtt?=
 =?utf-8?B?OEdkUDFPM0M2YUZxQWFIQ3drOFp4djU2azREUUdKZWxsZzQ1TWFiOXZ5bWM3?=
 =?utf-8?B?dTgwZXp0SkZaeUpRNWdEai9zNnF3YmVRbXNXUTI0ZGZKY0VNb1NoT3BRTXJr?=
 =?utf-8?B?bDVSbXhXSGwycTNzTGxZTDFlU09PbkxoLzVJQjl4d1ViaWNkbUF6SFZWNC8w?=
 =?utf-8?B?WEEveG1lNDBLbE1RamRWNzZpOVc4SCt4SUd2cUV6VkJQVGJldXpDMFNpSm5K?=
 =?utf-8?B?T0lzMDFKZDRDdm4yckhKbGZ0V040VlpVMER3S3VYanRIQUhLUnJxUlVSb3Ji?=
 =?utf-8?B?MzBrM0FOTXRNRnZ1ZHpYVVlRUmhpUTBmWG1jNlEzenkxWk8wZ0pHWGtiNFFz?=
 =?utf-8?B?aXhVUkVFOHZiNzVER1lYWng2OHFvaHBJc0svWmdWSXp4VW9zNCt3OHhCVTFm?=
 =?utf-8?B?YXd4Zm5wbkllY2JJT0s4N2VzVW9HTHloeEdTZkErWU14RzI0ZmdxTzdtRFRs?=
 =?utf-8?B?ZVpsU21WTGVTcjZ1Sy9KRGM1K0NLNEtIYmxqcjgrOE1sS0NiczBudG9aL09C?=
 =?utf-8?B?M1BwVFc0eE05anRwTCtod3E1bnF4bjBiM3hjWkR1V3lJeEFwaEIvUVR5bEs0?=
 =?utf-8?B?TlRVc1FsTnJBNTFjZG1BSlFjbVJBa0xBV29sU3hCYlpVcCtUckFDWG5CZmx1?=
 =?utf-8?B?eTJZN3oyVlVvU3hydk9yOFBHSElteUoyaTJEMHlCaVBUOEgrbDBBRXVzeFBJ?=
 =?utf-8?B?bW13d3BNZi9Ic21ETmsxaFhYN2IxdDhHMDg2c2NZR1I5WEJXTWo4Q0l4ajZM?=
 =?utf-8?B?UHZvVXFXaDBmYWtmUkxpUE05RFd0QmJZRTlFNWtsYldoeXdGd0kzK1FXbnFh?=
 =?utf-8?B?U29HeHBHVGNpUFZISGtLVm5ScUdIU1QzVnNKZmY5dTlSS0lTeXJFQUgwZlNs?=
 =?utf-8?B?MXNWNVdieFBMa0VKV0EvN1lBRUk4bHZTSVN1TjVYTTlYUWtwaWJXazVKMWZJ?=
 =?utf-8?B?VTNIQ2RXQklIM3o1Z2YzV1UybnYxTjlQZmhqK1NPN3dMT0w4bTYvT2ZpWFpy?=
 =?utf-8?B?RTVyVEpPb0hybkFwMWNGelcySnYvQUQrUlBJbnpia1hMc29FcjFOTFc3S203?=
 =?utf-8?B?aXAyZmlnTTNZc01oZytLYXh0eElyZ21rRTNZVWR4V1NJVVByVHljallqSVJZ?=
 =?utf-8?B?anlEcVIwcndHSVFObDhpMDVQeHVJR016UnhoSTlsd2FaZ1d1cjB2Rm9sTEFv?=
 =?utf-8?B?cFZwcUJVS29XMGpDSkVEMFhPMVhUanRzRmgrT0ljWVJsSnhhOElwM1JLOENo?=
 =?utf-8?B?QWtWQW5SNnNqaXorWUJLcXVaNGkxOGVEUWNnOXpnQ0pPUzNXSjZsTjkrcmF2?=
 =?utf-8?B?MFUxNnpSTTZIZU9tMEJoY1hUNWk0RzNZQ1NTM2R5SFJlS2FsOThlWHJFaVc4?=
 =?utf-8?B?M3NhN2ltMXc1c1pDamJlZ2lwVHk2MDhsb3Y3a0hXOWFHYXNNdEdVMnZaUndQ?=
 =?utf-8?B?eGloZG1adWY5NjJTd0gxMU1RbE9qZEZ6RGlxSnpXa2I4NHFDZThLQWhxWnIv?=
 =?utf-8?B?WmhPSHJwUmpFVFF5NW9HU1MyZU95Q2RzU1ZGZlB6UDI0a3ZXd1B5aHNnN29O?=
 =?utf-8?B?eXNZOUxkdVBWeXdCTkNnMVRLM1JLWmN4bThUQnZsL1RaTWJiY3dVNXQ5T0d1?=
 =?utf-8?Q?2upxVhLXckDak+B7YE08RW/xRoZaI7qZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dENHZzZaYXFOY2IydGRWQ0xNVVZqdEc2TUlvZk9mYTJRalVvUjRCWUZDL0hB?=
 =?utf-8?B?VDhkLzkzSHZqWW5RWlR4MDF6b2ZKUjg5OUVRY1RJMzVGQlh2QkFPdUpxRHZU?=
 =?utf-8?B?TnplU012YjAvZFRWWGltVndyQnU3ZEJNTlFTSWtZQVd6NUQrVTNCajdnckhH?=
 =?utf-8?B?Wkw3TEdVMlRNNC84UnkwVkFXWVJHOWw3OUdZUjkrVjlVMnI4ZUxsU2NUQUlZ?=
 =?utf-8?B?RkQ0aHhEeGtRVGczclNSczhPRnpadFVEaVArSy9Mc2NMTkszYkdCS3lQdzhI?=
 =?utf-8?B?TU1KNzVyS0NqSjJZKzh0RWNFZWZVNlFoa0RIT3dMNlEzSld5QzZhNVJmZkhq?=
 =?utf-8?B?ekpCY1p0aUlGc1ZFVDVhRGgxR2ZxKzRRQ2pTNVlRZzlQNlgrZS9VQlVReFU2?=
 =?utf-8?B?UmpQNFp0bGRHOGxBSFpFUUtORExGOENkU1VqOXlsTlRFRTM1eHBWcEVmeW9W?=
 =?utf-8?B?TTdVc2NxMFpMUTVxVDhmUitzTGYxakJsWVVmeWZPMkFBVUpLa1QwajdPWXRP?=
 =?utf-8?B?Y1RJMUZPb01kbmRzaFQvZ3ByOCt5TWhiYi93WHJvYUFybEVjbkhqWjF6SjFK?=
 =?utf-8?B?UDJ6SnBGUlU0RmEyWHhRb1BCQ1hkUGNEUGF4Z2ljV2hFMWNrRHhRY282Qjhu?=
 =?utf-8?B?RDhobWdlTkRBWXUvRGN1YkYrS3pGT3dDZys1MjZwRCtnWWhVV0gydG1HN1Nz?=
 =?utf-8?B?MGZtZU1sb0J1ZXIrQnVxSGVkZ0NDd1d0T0d6ZHB3SUdBUkpPcGZxWHh0ZXU2?=
 =?utf-8?B?MENsSkttdExranZBdmIxUmMxOFE0UHJueXNMVGZITnBQVlRCK0Evb0NZVENx?=
 =?utf-8?B?N2hML0JLNVloaklXYU5PWVhPNnR6bzU3akxPakdWSEVsbXNTOU9CNUtSMWlC?=
 =?utf-8?B?T1Q3aXhvT05PRjlOMlJXOHJHVHoxU01oT3gyd1NSNis1MFduN0ltVkcrTTlV?=
 =?utf-8?B?MzQwb2w1V3U3LzZHNndaU3pHN0JxSGd6L3pkZnZleXo5WTBhZEQwVVRTbVQ4?=
 =?utf-8?B?Q0c3My9QV2IwenArQUZzRnVSYzlkOFpXc0lSTDM0VHZsczJ2OUw3bnpsbk9k?=
 =?utf-8?B?YnVnYk43RFplVkVlVUU0ZCt4TWlpdzNidUduNzlqZ3RlMUpvTVFlVGhFdS83?=
 =?utf-8?B?SHNJRlhSK1B3MmYzdzZDOWQ0cEpraGJuNS9lWW9WZUdjTkFKWmgvWExGU3Rz?=
 =?utf-8?B?MndvZlJReE8rSlFIVjNEempFc2xoMTd6SlBkSS9ja0pxQ2RvenZFSVJ3MDdG?=
 =?utf-8?B?T3YyQWRXaEZZRnA0a0JYK0JWaUFmTG41Q0FwRytDOFE3QXFaUWtlQlQzNHRy?=
 =?utf-8?B?TzRzaWI0Q3IyMitacGk4bFZ3VXN4K3Ird082RURMOURHc2ZmZjNGZlFQeHhm?=
 =?utf-8?B?WEdLakJHYXFScVMvWW42THY5ZmtpMkI4Tk1DUXIrV3AwYzhkMzJxejltdE9S?=
 =?utf-8?B?STlFdUhKRlpBV1NKclhZWmtuNlB3UmNzOVRuUlJyRllZV2Y3OG9TU1NVMGxh?=
 =?utf-8?B?MjdaYzMyQUZEaEdxWm5hMGJMQ1EvcndpY1FqeEVvT2Y4RnVxQnl0Q0JzeHpH?=
 =?utf-8?B?SUtuVVVEclhaOTFycHZwYzFJZ1Y1ODM3WWxDeTY5Qi9GOUdidFBzdXFNbEt4?=
 =?utf-8?B?cFRTekdWLytEY09wQWlWTDZOM20xNDR4clR6cVF0QVY2ckluU3l6cjJWc1lB?=
 =?utf-8?B?dlVXRkxHTkhCYzUxRTlpQWsrYS9mcjdNTzVXMzFoMHpiY0Y3MjZVemFEV25O?=
 =?utf-8?B?NDRHV2c5UE01MWFBVHMwMk91V3ZlSlFCUUg0QVgzbFYzNUpncWVqazZXWDZ0?=
 =?utf-8?B?TkVkV0xuWmVEOCtDWTFJWVFLeVNLdkg4cG9Ha1ZHR3hQdVV3NDVxYktuRHQ3?=
 =?utf-8?B?clZ6OVAva1lkSzNnU2xsUkFqb1FPS0tZT2VwUDQwS0E4S3prV0tyU3hheHVk?=
 =?utf-8?B?TzJ3c3A5TXozMTNjeSt1REdReFN6NWFrUEx6ZStMR1dlRGoxSHY2R3hqM2Vw?=
 =?utf-8?B?T3NTWmhCdS9rVXUva0xkV2FWQTJZWkJqcXVDWlhudng2cHB2Qmd4dHRyZGVN?=
 =?utf-8?B?YWhLaVhCNWNPWVJNY0hERG80TE1kRmREc1dZaDdjK0IyajlYMDN2VlVKRzdN?=
 =?utf-8?Q?FGz3xak/5B78W+IF8K61qDaxG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d461a72-0b28-4563-7a86-08dd75f3cc7d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 16:46:53.0370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e2Kgm0jot6GCr0iJmawaa2GIr93NYqI68RDdJhpiZyN09qqPVU92mebvY9fTs5A7i1xjQ4GeJJknXIWa4PMJBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7029

Change binding to support optional error irq.
Add error irq handle for fsl-edma drivers.
imx93 dts add dma error irq interupt.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- Rebase to v6.15-rc1, fix conflict at fsl-edma-main.c
- Link to v1: https://lore.kernel.org/r/20250228-edma_err-v1-0-d1869fe4163e@nxp.com

---
Joy Zou (3):
      dt-bindings: dma: fsl-edma: increase maxItems of interrupts and interrupt-names
      dmaegnine: fsl-edma: add edma error interrupt handler
      arm64: dtsi: imx93: add edma error interrupt support

 .../devicetree/bindings/dma/fsl,edma.yaml          |   4 +-
 arch/arm64/boot/dts/freescale/imx93.dtsi           |   6 +-
 drivers/dma/fsl-edma-common.c                      |  30 ++++--
 drivers/dma/fsl-edma-common.h                      |  18 ++++
 drivers/dma/fsl-edma-main.c                        | 114 ++++++++++++++++++++-
 5 files changed, 155 insertions(+), 17 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250225-edma_err-5a7385e45800

Best regards,
---
Frank Li <Frank.Li@nxp.com>


