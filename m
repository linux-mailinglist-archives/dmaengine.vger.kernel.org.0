Return-Path: <dmaengine+bounces-3976-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB039F2B4A
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 09:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD02C188717D
	for <lists+dmaengine@lfdr.de>; Mon, 16 Dec 2024 08:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4288B200B8C;
	Mon, 16 Dec 2024 07:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VuVn1tm9"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454DF20010C;
	Mon, 16 Dec 2024 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734335923; cv=fail; b=Dm9j4Bsh6LjXNCTyHm66DhyVzwD1/jX/0NtutWk2GAPC+MDyE9Q2CBsGdYStebZaMuUw6XCtCPpoJLtHdgNVAklt1ekLE1E+x3Dd4sdB/mOpHiq5r4acKH3pwJYCBA2rREUn9BZS9g4lw0mR6gxSQWPVFRrS3laeBZa7rZaxAyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734335923; c=relaxed/simple;
	bh=7P8iy+1K7O+WsqldVxSfHKaqm9+AtvwDcCl6yXl8WmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=No8OG1XiAHaW7us0g8BWqFjSCJymHUl9wrMrY3PssGskWu0lA4/RtSoiq3OB3FvrSDUXQ7vg7Lshtki8BzMrRThzRjB5vbJyi1jGZZGhANDJbvqRLFM5GnXZbC/iPDC//3uVQqJae4wDJA+cTvyFebsUKQFyuA+Q6ORK9EH86Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VuVn1tm9; arc=fail smtp.client-ip=40.107.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jG6kWGHZ/RQas0ELCmWPym6evuW27g3P8KIlDwNdgf8Jh8no75UTOsVK5cIo6E+El+l16SMx3rUeSLFa3rIDHMpcVXH0W+9oKzawKIj986QdrxrgmPJ/2qJjMGzI9+dNIsfFy/ZbkOJbnfEt5By8gMV+CgP58+KPltaFpokZlGBKr0Ur5nz3DdnKzbMKyPN0ZRD0qomk9+3orixQS8kbZdFiCLWE8pMAeRCgFVkCMRnf3CGlMVT7iPNNxPHRfuxC64g1pe9SqWIHld7kQCi6sJk56eqbEMogsLu02sE+5ypwQp67/V9Jxt0oF79gz+EcHY+yP10GsF/Val3wmLGzqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mt0jsr+pIJWqbLu1JPSusncKOHpHouhnLY8gLp53tRo=;
 b=SJaPNFbUvEWGIbdOJeVclWrppl+hB01jrLSOcPBnRUcxDoi+Wn0iSGgeT5e/lNvIzCMy5CTPxf8PWcoM9CDcAOiNVsv2Y1TqV2OL2nZ0GWk9lptO32tQ5sQvPhEE2tONda0FPL6Yj448CsjQq1ryWDPzUCjfH6g2BSFG7ewYvMwE2yq5zlaKeXMPWjT8jFsLFkYo+R4CJ1cyVt+Mg0MuZSI5+vbRc+5lizjM2zdVub6gi4/kwIO/11SWOmcY3q4CHumEPiDHrjwUJQjC3mJXDBI1O1a0KNTXYqHmubVgTrfQOjf6rJpse2FJOvlqeSRU+EQipaaqrprxPEd5Z4GRbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mt0jsr+pIJWqbLu1JPSusncKOHpHouhnLY8gLp53tRo=;
 b=VuVn1tm9lcK7MUBOyHlBx+xcy+xBUUduDNtbxwbQzRYfUyWdSgMxqx1LmsAWMSPcw0sDxV5TDKCsB3M2V4dHcytuJsg4qoRfheeWHgQdlbmthhNAHJCxiYIC0sN4OSujzNl5gML5eF5eyOTckf+N9pFM+oVF7RdJr9zbmyTNccdyKnjHCu7gSK4npyhKIaiI/oIoOiK+Y0pLEVKmpQVwDO+IqLPmWgyiPoKM5zFbG56KWWx90pdjX9+yB2C2Db417IaScEMl95rCnVcPw6HEfKFxKZIut1qVmiT9BpiXoGXEiFsqDMmb7/dkpGUNA2Ljw0yzOY80GNGs+3cy4j1xlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 by DU4PR04MB10361.eurprd04.prod.outlook.com (2603:10a6:10:55d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 07:58:34 +0000
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7]) by AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 07:58:33 +0000
From: Larisa Grigore <larisa.grigore@oss.nxp.com>
To: Frank.Li@nxp.com
Cc: dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>
Subject: [PATCH 5/8] dt-bindings: dma: fsl-edma: add nxp,s32g2-edma compatible string
Date: Mon, 16 Dec 2024 09:58:15 +0200
Message-ID: <20241216075819.2066772-6-larisa.grigore@oss.nxp.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
References: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0080.eurprd04.prod.outlook.com
 (2603:10a6:208:be::21) To AS4PR04MB9550.eurprd04.prod.outlook.com
 (2603:10a6:20b:4f9::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9550:EE_|DU4PR04MB10361:EE_
X-MS-Office365-Filtering-Correlation-Id: e3414a4d-dfb2-4583-a055-08dd1da77007
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGIrS3pUTGFJcTRSMHlvM0c1RGR0YnRlKzVXM1VLY3d2VXlyNkovSXNna2x4?=
 =?utf-8?B?VjR3ZW9GaGVzaUJVVDV1WDF6NDArN2xEUGk0OWhXWko5QStsYVM5TFNEZmtY?=
 =?utf-8?B?WlNFMTVKZlV4Skd0TnIwUWl4NmprM0gvVVZVbUVnVDZaaDdrZVh3NU9tcy9B?=
 =?utf-8?B?WmRHMjFsSWs3S0IxbnZkS1c3NytZVENXc2RTVE92RGxBZG9URnJZdS9ndWdG?=
 =?utf-8?B?UjAxMm5LdTNtT1RhOFJSc3NLQklnQ3RDSXFGQjd6Qmx5RW1heFVXR1h1dUdY?=
 =?utf-8?B?cmo4OVZCM0ZSOVc4SFhYZFhWMG40ZU1zTmNpRVVuMEhMT1F4aTg1aElyaysz?=
 =?utf-8?B?MGp6UTU1cTI3dDRZS2ZYSGY3ME9YSWRqNTZqKzN1azE0VU56ZDZodnpsWHA5?=
 =?utf-8?B?eHJ6M2w1Zmp2cG05WnhuWC9yMHFJZkpiRzUvN2RIQU5aeGhZZkpNanYrWGxQ?=
 =?utf-8?B?RHhTTDd3Z2l5aHJRRnZXMlcrUEtDaC9GMXFRMFhYdmtYV3VmdSszN1o2NmRY?=
 =?utf-8?B?QVFFV0trVWh6OU4zazBxdzhSditEcVlrNTBvRzQzVStER25aTjgyUGtiVktX?=
 =?utf-8?B?TXhONy9Id1l6SE41V1ByT0FrQXc0TEJMenNGaGxZdXlmdW9hTjJpRWZiQ3pF?=
 =?utf-8?B?ZjVxQnFLcGZnTnJNdXNBYUF3dFNBbWV2blgyOXJDYzM2bmlFci9LTmpPb1lY?=
 =?utf-8?B?ZVhVajVtanJDZmxoTndmenZPZC8rMnl2cWVrbzlBRXNNTjBEMVZuc1V5QzZF?=
 =?utf-8?B?MXRqRkRXU2xOUXZtMVdvNDlGU0U1Wnc3cUhmRzUwWllhaVFRRjFLUzkxNm9G?=
 =?utf-8?B?dC9GR1Y4VGhqMFlDaG1OeDByTm5IVnJzeGdqajNRMTF5WE1acHArZmVJWUdW?=
 =?utf-8?B?dDlDblRkemRjZlEwem44MWIzaW8wYlJyTlNKWGdINmZ2YlExZ2xzRTd4R09J?=
 =?utf-8?B?U25VeFZsczNvamJLVGtwWlIvSkszWGsxL3pEK1BhODlDODJzUW1IbGpqWElU?=
 =?utf-8?B?Y1JDeHNsalZtWDF6bGpYNWRwQUo0S3BVNFZNOU1hejdNMmxZbDdFbmRoN2dJ?=
 =?utf-8?B?Mkd0MmFIZnlpWUV5dzJQUWtnMkw5TW5xZ2NNNHJjMUR2aGJGOTdUelJ2QzlT?=
 =?utf-8?B?ZlZnajRZcStJN3BObjJvSHd6Z0loOEJ5L3dkbEZ1U3Vacjc2d2Y1Y0pUeHEz?=
 =?utf-8?B?UWxDTWpsWGREcWdxN2VUaWdBS3RJaWFIMCtzRytxWWlFWUYyQWxHL1BzUTJn?=
 =?utf-8?B?OGZqb1Zhc2d2T1o1WlU4QnBvbkUwT0hwSHJxTUtoa0lqcDRCcUYzTlN6ai9a?=
 =?utf-8?B?d1VobFdkZHFWbXozQjI3OHFxKzExTWFkSFI5Y1VMd09QK2JkM21KQnBqZmo3?=
 =?utf-8?B?cEZGeGMrZ2p3OEFzVzRMN1pLaUgyMlZOVkV2SmVYeTBrSzNTbURtNGhWUFdl?=
 =?utf-8?B?Z1Q3QktLc3lFS3YvdTc1L1IyV3BKOENEMk9TMWF2V2JoSEI4VXZ0N2Y5dDFB?=
 =?utf-8?B?djh1NUxGR1JXa1BmUzNCUlNYUmhEQlR1Yi83WHRrc1ZhTTJXYUphUzJrYjIy?=
 =?utf-8?B?aW9QZDhlcmY3QlZQUWtIL1FCYW5IL1NhNVZjb0hocjZ5bk4rbDZWajdoTEVO?=
 =?utf-8?B?d3NmcXM0cCtoM0czTXhmZnRaQVh5YjI3RHR0UmhNNVFmN29USDR0MnJ0dStR?=
 =?utf-8?B?M29KUHk1NGNPRW1VY1B4OEhUOWdKWGozLzlIQmpYV293c2QzWFlaWU1Jclpl?=
 =?utf-8?B?UldDU0N3cmNlTDltVHJsM3FLbktwY25UdGI1VnZ6b29zZ1ZFUGlrU0RuRUFt?=
 =?utf-8?B?REU0SWRJQThEZXFmTXp4czU0ZmNXVTlYdzNvZTNyNVRyc0J2OURYV3IzNkVL?=
 =?utf-8?Q?CZ4pxVA47k40C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9550.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTJJSS8vRUd1SGlSNkg5ZCt1MmdBZFQvQnBzalZoV09RY21tVDEwcmZ0aVhj?=
 =?utf-8?B?a3psSWlTMjRHTUVhSVNQSW1ScFRLYmU4SDc3b2ZSbVQ4dUJrR0F0Z2pNL1pj?=
 =?utf-8?B?SmZrd2hTbzZjYXcvY2g2T2t6a1B6M1gzaUEwdm5hemw5TjY0WXZ1SkQ4Z1FL?=
 =?utf-8?B?NXZ6ZnY5YUMzZk1vNU5zMXgveXZmY3VwTnlDTmRnYThaRzlxbnIzdHhVQzA0?=
 =?utf-8?B?bXQ0ZmR5T2hDdElHdlkzREtjU3JaOE1OWjh6TkoydDZzYVQ5YXJTY2tzc1ZR?=
 =?utf-8?B?ZTFWdm9seEFYMzl6Y252djZxSWtRTzZiMFRSQWlXTlBmcjdiakEwbnhWeU9Y?=
 =?utf-8?B?cktTaDBzdUxpTzZJQnBxQVp6RFo1bGFIZVZBNUxJek1PRHN6ZG5rOXNZR3E4?=
 =?utf-8?B?bU1kU2FmbWdURzArUjYrQS9BZ0hKSlR2bFBuRnZ0UCtJeEZHb0FHSENTdmx1?=
 =?utf-8?B?RWRiYWtzcEE1QXA4eTQ1M3duZ0RGU0UxZThzaWdRL21yRVRYNFBDVkdha2tz?=
 =?utf-8?B?d0hxM0xUcm5seW82OGdFVjA0Sm1QTjI2SWcydlZzME5sSnYxTUU3ODgwRDRa?=
 =?utf-8?B?ZEFQUmVZUXJYRWtxUmhDOHBrUVJib3IrUmxPVDJ4ZU4vQlBQdnVuamlMTmhH?=
 =?utf-8?B?RTYzeEErYVdvUTRMVTUvcVB5bUc0NVh3WTFrTEo4MFBpNE5zMUpGdGIySkpS?=
 =?utf-8?B?cXNELzNnSlJTNjcrTk5FdElLRVlRK0hRVUdsb2FMd0xYVGtQSGF4bEVJZFZF?=
 =?utf-8?B?NkNWNG9pa2VLcHdMbkw0Q1lERTVDeFdtdzlQQ3k1SEx2RzF2dk8ySnpiQU5j?=
 =?utf-8?B?T3lYbmovZkRUcVJSdHV3UC9kTjRHZUhsV3JlNDVTblpUR29VOU1aN3A0dmN4?=
 =?utf-8?B?S1pTSytPb2ozWjRUdFNGWFVVbG9YOTNQRU9PeUprYUhHK0dmZmkvV0xRN3NS?=
 =?utf-8?B?cG01cjhac2NqOFFQYXc2Q1M3RmtGcHBxaFBaeUVwQTI4b2hxbm5pOFhpMUlj?=
 =?utf-8?B?MEVZNGN6RDMzTS91TGRSWDFmendFRmEyRk9jZWRHWHAyV3Z4emJjK0YxMHU4?=
 =?utf-8?B?ZnhaSUFHNmhWUDRvaGlzSGhCekR6M2dlRlVUYk1wRzEzVXkvNThDZmhyZU5z?=
 =?utf-8?B?OG9kNzNxY0w0RFRqS0FoMHk4OVlyZk1hSWZPQUZyNTZwZWlGekV1Z0J4VGht?=
 =?utf-8?B?dlRyMXRKOGdMVE5KUEx2SnlFK1FaM0k4K1QrNHZPR1IwMFFHRnh2RVNkd3FW?=
 =?utf-8?B?USsrN1hlSlRzNU54VE1rb1RqRm91eVphREtLUEZ2V29hd213dVlwSTRvUjdH?=
 =?utf-8?B?TEtsTUxVellMMVozTWxRMzFvTkxTVHpUb1NLdC9OV3Q2dmkrRUJOSjJPeWMr?=
 =?utf-8?B?SGN1ZndEWVFGOHJMZWxUc2RMcDl2SHR6S3pEaER4S2x3Y0xKWHcyUXBrWVRC?=
 =?utf-8?B?cWNRTUFXWHR0SVkyUWJCK3FWV2t5V3YzOVJUQkUzSUVPUkVaK0RKamZCSnFD?=
 =?utf-8?B?VXZLUDZmNmljYi9MRGVVZHk5WG03bm5keWYvQ1VHVnZjVElwSlRjZDN2Rkwx?=
 =?utf-8?B?SGFwaWtNT01yRVdHWXZTZGJrQ29IYzRsNWZXM2p3OHhsekw4RXF0cVVZaE9Q?=
 =?utf-8?B?akc3cHBtTEFJeW13ZG0rMUxzQUMyYnVUVEY1V3dOTGJQZWVQRXVydzdvbVNL?=
 =?utf-8?B?RlE5TXVlckxmaXhyY1ZoZ3FwQlFYZFVuWDhNU1hHb29OTFlScjZNc2thRlMv?=
 =?utf-8?B?Q0ZwMjZKRU85STZmVEZ3cXZxemtNdmJYWWdIK21DSzl3aHRhM1NSb3RZRDg3?=
 =?utf-8?B?VG1ZQTFNZkNMTDlURXBpY0ZBSkdIdTB0UXloR29jL0tKbXBnVFhGb0dCbHN0?=
 =?utf-8?B?SjEwU3J0RXBZR3JFa0lNMmtsK05MUFZ2S3FGeHFXcVdsMXFIUHVCaGtLc2xD?=
 =?utf-8?B?eDNXdXliMVBaNUgvaTJqVXBoaVdrRGJuSmo5c1JwajFjeXQzMDhCcjlBWmNW?=
 =?utf-8?B?SmxXUUNGV3RVclovVkVzOG93YVNWaTQ2T0tKRXhRN2lkVm9taGJhNVBBRndI?=
 =?utf-8?B?QmV1eG5CZG85VXp0Y1FZZHJ4cThMSmJldjlheTVIbHNleHVPeS96YnVYa1Y2?=
 =?utf-8?Q?/YCU2T/xGt11gatUMvNIGRlYO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3414a4d-dfb2-4583-a055-08dd1da77007
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9550.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 07:58:33.4257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cm4wrEKeFBENpmXGc0jOnHVN7Yl2DaDmT+P8XvR1i9u64K7DLsBrctpHxFIwfv8IgyUF0M41/Wkw4VYUVjuYnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10361

Introduce the compatible strings 'nxp,s32g2-edma' and 'nxp,s32g3-edma' to
enable the support for the eDMAv3 present on S32G2/S32G3 platforms.

The S32G2/S32G3 eDMA architecture features 32 DMA channels. Each of the
two eDMA instances is integrated with two DMAMUX blocks.
Another particularity of these SoCs is that the interrupts are shared
between channels in the following way:
- DMA Channels 0-15 share the 'tx-0-15' interrupt
- DMA Channels 16-31 share the 'tx-16-31' interrupt
- all channels share the 'err' interrupt

Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
---
 .../devicetree/bindings/dma/fsl,edma.yaml     | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index d54140f18d34..4f925469533e 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -26,9 +26,13 @@ properties:
           - fsl,imx93-edma3
           - fsl,imx93-edma4
           - fsl,imx95-edma5
+          - nxp,s32g2-edma
       - items:
           - const: fsl,ls1028a-edma
           - const: fsl,vf610-edma
+      - items:
+          - const: nxp,s32g3-edma
+          - const: nxp,s32g2-edma
 
   reg:
     minItems: 1
@@ -221,6 +225,36 @@ allOf:
       properties:
         power-domains: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,s32g2-edma
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: dmamux0
+            - const: dmamux1
+        interrupts:
+          minItems: 3
+          maxItems: 3
+        interrupt-names:
+          items:
+            - const: tx-0-15
+            - const: tx-16-31
+            - const: err
+        reg:
+          minItems: 3
+          maxItems: 3
+        "#dma-cells":
+          const: 2
+        dma-channels:
+          const: 32
+
 unevaluatedProperties: false
 
 examples:
-- 
2.47.0


