Return-Path: <dmaengine+bounces-8916-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +F1ROmBTlGl3CgIAu9opvQ
	(envelope-from <dmaengine+bounces-8916-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 12:39:12 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCA214B7CF
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 12:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AA52300275C
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 11:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777982ED873;
	Tue, 17 Feb 2026 11:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w2291CA2"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6304332EB2;
	Tue, 17 Feb 2026 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771328192; cv=fail; b=OBeyW7Uac4E/YhvsJySMtFYBd8mNeIMTYr+01N1k4hWcR4FBqTZhBEaA+jId2DG0qt1aheVFasaHo+O43t3J82NCB1zmZtTqBHzRfXmR13MB+bfskKCWDmrJfDEgt+jq69CW8xoqrG0ppJAsvpQM6aVJtfnLhwuJE4glFnjqwrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771328192; c=relaxed/simple;
	bh=PwTwiftEO7XT+qkiNbWtUX1ydW4+F4YntCWO33VXJUw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EfuCmecyvzZdPzkllJhHhWcDhbLIWbrmdXXK+lTp8auHQgzELRbIgdaiYJLl5DS9DQS45AUtyNK5HjrcdpzXj9aLCDRmiYzCzLoVbJ3ZgfSkix5AETYjKeJL5H5TkYdyHL1q2MswDf1IZ4nzZ0hoogQ9J9vjSGhCSf07w6odB94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w2291CA2; arc=fail smtp.client-ip=52.101.62.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzPJZlbA0YVZ3qCEz8yD4Bgi0MTg2WNSl4e7kcHxjqVhqku/boj4r86DHIt0KRcTWMoEX2DWXQ4jCLn3W57YEmplobhs+iusQNhQFgd9R+V+2RY4nrsgMJdyCxV1ZIPml5u8w9j1QJN8v8wqN7PKKHHpd9dG6+IN2rLn+KvLOtEJhpSE4KsvjExV894c29PJd5lYFO0z9NVd2wLirjhpf86eNnLFgyFE7fFB/gy2BOURvuO+JgV9hKxRGdk0+2noBVouIgRb+hekhIRFTJ2GBRpQjHJ3fejCU1ROInxEWuORSuFSgRe3VJFyNzwXZ1x39gUGfbpT4Te8E/TgbN4DFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YDBbXIlkXwwt+usoVjr4Ekx2mpb9R1MbVOi6hzRluA=;
 b=gVcB0uJTU6qPwnMDAravzKC3JfUego55Os1eBUvWoQEAJngV0qg+zJ2CXlpN0c8cxMlT9/poUH0n9KeHFOCap6CNFKBzw9NzqL8hLr37/WRko0OtCi145yEN2/2IjTmk+QUaiAZXRSDYJvnbJVeojGx+VjTxfmHk9OetJ5nRaexZX1vyMDGePuBDSFbrH0dD2Z4v/Or+KmRxl9qkOdgWjgRe7v+DEGteL0v5DfLHzAA5jjR58Lv6+fgVgUVus4I+xBdvUbMxInVmNIWp2HlpGaGlxytNjNYCO9W3/KajgA/qi1A89OKsLwae32yMD8Nb2j/TZVYt4BW+kgb+V8hoSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YDBbXIlkXwwt+usoVjr4Ekx2mpb9R1MbVOi6hzRluA=;
 b=w2291CA2jcgJmdcIRX6iydIdWoCLw3ijY9xLQZmA0kt0078ErUba/JCjgAV9ds3q3OsTMDmYQ6JjsmIuDUbuThmJaa+BnHAebVDhCNh+DkD/SaJmBQL/oLavuqfkIHbNPi/HvAPD+j7HXde5YI9LZlmCowDLO6+XFps6qgeKYfY=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by IA1PR12MB7591.namprd12.prod.outlook.com (2603:10b6:208:429::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 11:36:27 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 11:36:27 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Frank Li <Frank.li@nxp.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH RESEND v10 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint
 Support
Thread-Topic: [PATCH RESEND v10 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint
 Support
Thread-Index: AQHcnzLW+pz7h8wBVkyOatEPrV1BoLWFtlMAgAEOXJA=
Date: Tue, 17 Feb 2026 11:36:27 +0000
Message-ID:
 <SA1PR12MB8120C6E264A44226A79C24A4956DA@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20260216105547.13457-1-devendra.verma@amd.com>
 <20260216105547.13457-2-devendra.verma@amd.com>
 <aZNvwOa4sexnlHdy@lizhi-Precision-Tower-5810>
In-Reply-To: <aZNvwOa4sexnlHdy@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-17T11:35:39.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|IA1PR12MB7591:EE_
x-ms-office365-filtering-correlation-id: 796020df-0897-44e4-cec2-08de6e18c9b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dJyZ67TB6ekR1opHQXBDbnrtm0q0Q1xJ/E5apuj+r895MkcT1KKt7JbrMz0i?=
 =?us-ascii?Q?RmZQGB13GCFM++qEBCwohs/o6pNyzYzFnFOnM9fJfjgU/kR/RIwabiBGYgFi?=
 =?us-ascii?Q?nCYsVlXMLKJbhg7DwF3u2MJlhysNau7AcDv3PLvK9jzUoxsPhiJ1IJQ1FN0c?=
 =?us-ascii?Q?YkHBz83ovU/6R1kdGDDzvBCdlsGtnPrHXrQUWsRsdrxNmV1tfFaGXdO+BFwR?=
 =?us-ascii?Q?6RS3Xea+rlrD9crhYrG4CQC7JK5fHQbmjgWlNfVoGpktt4uXl1+vPFawq3nU?=
 =?us-ascii?Q?iKB0IkalH0yjHgB4aVuaDSAJpAEFSPqA85nCTZkQF2PLFAsPDZx3ujxZQX6G?=
 =?us-ascii?Q?kq/dlKakfixk5lCjJmY5OSElJpUP+NvalJLVzIpoclkhUS5NhwvaxN8Ll/Ga?=
 =?us-ascii?Q?r518LwmGH7NhNnK0uMCCtRWnZz4ynpzwGDjwaGcSedICKtbGaAbt+AzK7735?=
 =?us-ascii?Q?pLL9MlhkU6W4xzta7R4T+OcgtjqVttvouFCEG2D0hU2bIhs0bgtjMRrDmQOw?=
 =?us-ascii?Q?kZXpWADtS+CgQVVThMVT0TBJlriI0h0tC4sdysjOsgsqwqHUFKveVldc0mgF?=
 =?us-ascii?Q?iqNlwshWEHJvdN6B7rGLBwEYBqtD0FJMt+TlRQcJz6Jum5ODwQqOuW+98Sda?=
 =?us-ascii?Q?IMdkQYrzM1ZSPJXNLGYPmXiRavuuaZaaA6fEhcPN4BrSzSeKZGfcndgXy8tE?=
 =?us-ascii?Q?Vh2XYodQjZMwP29X5vCdJf7sL/lahno3iJV/pPdoyjKygha4UHakiEDof8IT?=
 =?us-ascii?Q?hJl1LssQLUOn+/Lxk/kyw8DhRYCC5Cj1iYnwNjdZhews2EkdeOcZRFTcR+uk?=
 =?us-ascii?Q?2TWu+yVZbNW+KSiLCXxstLKadF5x9xwZKnENHRXx/5l3DYaBFrYvbj8fbtKc?=
 =?us-ascii?Q?DPTuO3uyhkUY1LFDJRpoD0e4su/0468JnDdtXznwHXDYJoVBPYzWDyLRLUw5?=
 =?us-ascii?Q?eOYUE2RYYAKHwLvjRALyFp2Mdn5hKQxZpd+l6+lBLNronSKV2bJ8yaFURWGl?=
 =?us-ascii?Q?uQ7Xe7sLurTmCQAlbnfmc1VZG+ERJsvqRAC/PFkUQieQ6PrjJ//XuYIDhgW3?=
 =?us-ascii?Q?JO97QGiuofbKYjjg0rKrzfLSVWZly8KS++qa7JVscjImq8J29vlFChgxIMnM?=
 =?us-ascii?Q?EFbnu87PGFxamXV4e2cFtu73nevIaKC0Pf99faHDGPzx86WdOpqV8dqE4hJQ?=
 =?us-ascii?Q?UeWnLUD3UYOwn+ByLvkXg87ICvVA5oUj2apCjKQ4SuziVQlU7rD0q8uqr/lg?=
 =?us-ascii?Q?6UyJs2vyyDTsOLmL8HC7xJjA77/++VWpOcmi+UeSvbOhI4R7VZYrnlJ2ibkp?=
 =?us-ascii?Q?H4GK1RPHoEpTFv0sQhLIrGZDd7KEycnLW5XSq58B2vhIshX4IZdy1NI4glSp?=
 =?us-ascii?Q?0baeGMrIUGrXSjMZR3Rgun8t9gBD61dC4UrxeZ2VH2jRbGMAJ8QJVJu2Edu5?=
 =?us-ascii?Q?2ZRh1jk8y0PMw9TF+5NBcQEUK3DwUuBRlmbk8zdVqhcZ/P7lUK7g7w7ueVQR?=
 =?us-ascii?Q?vnAGqSGiGUwc0Zu17UOYyMKeu+v688bL3x5qY+DY6iDJhB9tkJQsRKeF+w3g?=
 =?us-ascii?Q?6EYf9bycl7xfIO6vTzZfpQyIfsFr/1Rbg7Uu2H4RkEP5GIisVbQqlk2aqyor?=
 =?us-ascii?Q?GTzPukI+J+Uq/9RG4c/k2+A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CCmNyxzPqleAy+NZ7VP+D/7SsneIAEcW6NZWCV5id0DPZ3oYA1GPVCi3RVza?=
 =?us-ascii?Q?72B0D8PdeNm2TBX8GJpqQh7H8yn0YiscJAhxI4meNME3xotXGOQXKg5a/HD1?=
 =?us-ascii?Q?vYcASr/zulgwMFq2R6kXg4+z/isvCbtlW8W+DtoRfvtvbgM076ksGgTjjten?=
 =?us-ascii?Q?XKjesZIkZleW19GbjViMmMVRMRJFS//JSjJMq4VyaK4StKyGvfutNYMfy7Ha?=
 =?us-ascii?Q?n1ODtamRhKJ++Fb3qPOcNn3YkQn1kxKCqxqnBhYgO6xCKLlTJ7ttBWSz3ILn?=
 =?us-ascii?Q?xZYy8Zx8dBiP4MCn6VidjL1u6EG7pa1Ts7YBWr2S8hqHYQ1lGL6wdiusCsuE?=
 =?us-ascii?Q?Px1W32Y9eGeRHqiKX2VbT3ltDNA/p76MIjpKYGlXX4QrMcvyLwgDS803DNmk?=
 =?us-ascii?Q?2c6sOzQ7YH8v2TVBW3gPnfa9ouOZj7BSvulqVNjxHDQku8Wzz0/9HafEUJmd?=
 =?us-ascii?Q?JDg+8MGURFyD6uBZtTbYvC38s74+jnWUS7piuhvLJ/40gX+GKHgXFB2feReJ?=
 =?us-ascii?Q?/E2xEAJzpCMz78XFOymlFv4ByKMRcF0ObMFGy7nfsFTOLLDNgrN8uHJ65+aD?=
 =?us-ascii?Q?5Taz8zkjcVtTqEWjxKRzcC+y+jJq67FnwWkcmmx4drEF5aPhW4drPnMuL/9r?=
 =?us-ascii?Q?HClNW8SLbFfgvvzo9Y4sC2iwEq4tQU3NTTU4DqdpL45R291VdiEYaPiJeape?=
 =?us-ascii?Q?OuPmh42y9z2vBEtSTQyfvXO5XCQGdZ3Zbi4fKO/NJ9PVu/jAV/rYkyvstOwy?=
 =?us-ascii?Q?NJM1y4/CjMjiQsWs9q7CYeRUwSL10WKvqXhz4uRtA5DABIYT58AtQbIJ63gR?=
 =?us-ascii?Q?maI/RWHGzd3evrOZb6E8cMNhqWH8EWvNe4goGvMs0TOPhUWEF9OFZ+MmdiTJ?=
 =?us-ascii?Q?LqwMRIhXrloHm9E4UGbhBcrZGJOFk8SC2MgxNjFF4ZPOsjjiTWDHHwraJvbX?=
 =?us-ascii?Q?JLWbsno5I42K7F9tdf5bX0WCTHa1wQBZ8FnFV3jD8B3vJhENNu+0FHdFW+Yr?=
 =?us-ascii?Q?72hyMfZUNQuTHwi2lZ1OYFkhu/zQ0Hl0+ogqWTutXgX7dJ1w98kRm8uvT3J6?=
 =?us-ascii?Q?+bw7wnr58q3ACGOlbmi2++Hpq9fLfvC2R0xBoPpoGHxdg410vesbrY3aY04N?=
 =?us-ascii?Q?YHHTNVAzKTYanXJAATIeoPk/tAfzzcCJ0GbrbLOG1q7sXM/u5LF+Ul936bXi?=
 =?us-ascii?Q?WaWmdA2r65YC4qAl8CdXo9uOZUoYrM0A0CsYy89iCSjWf5KCEeahmGsll2f9?=
 =?us-ascii?Q?K1/Vr7va+Ix//cujNYXB335VDJgsV/2AokpZCpdG1pVBbmoabL1ZCEjRPcGx?=
 =?us-ascii?Q?fhbCg24OYNSb3bMdVdvtAGtj4C0dGyhBBLzCTQbz8uwcIoPq4K3rYqv7nR6S?=
 =?us-ascii?Q?qCTt5u9gKuOP3CEF5qn7fKIPaZDVEnySPXiRUdCrcqpz5/L80OtLwgSPae91?=
 =?us-ascii?Q?wQ2Ra8TYCQ7c7nKdtcEwCv7gsJFzEQcb46CC/wmNhY6LmUJflaatBxgA8RVT?=
 =?us-ascii?Q?r+TCnVtfzTJ669iZosFvdtJz1PKLsjiKNfQ0BtUqrdYeycaPZgIVydFkAUsu?=
 =?us-ascii?Q?h8vU9TCTrjXFen54hMBLOFbBv9ZWF9ki7qiCDwOoUE3mnJuPLWkiUePo5l1D?=
 =?us-ascii?Q?fZy74kL1PmAXilduxkM0xE646hdiDHBtMp1QlstXQYbh+UJjNM7zb2eyWk00?=
 =?us-ascii?Q?lKKtjihAF9L/L5HYb8WN5Gk0GTW5T1l7LOn6YY5g3W714+6U?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8120.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 796020df-0897-44e4-cec2-08de6e18c9b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 11:36:27.5521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GB1YfbElxBt3zFdezPnedi+1mjrPSMd6V/GjEt6e0GWRA9RVB+dtdmDUS30LbYSj1EUneEpCm7ExXQ0xYuKuvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7591
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_FROM(0.00)[bounces-8916-lists,dmaengine=lfdr.de];
	TAGGED_RCPT(0.00)[dmaengine];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Devendra.Verma@amd.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+]
X-Rspamd-Queue-Id: 4CCA214B7CF
X-Rspamd-Action: no action

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Tuesday, February 17, 2026 12:58 AM
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH RESEND v10 1/2] dmaengine: dw-edma: Add AMD MDB
> Endpoint Support
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Mon, Feb 16, 2026 at 04:25:45PM +0530, Devendra K Verma wrote:
> > AMD MDB PCIe endpoint support. For AMD specific support added the
> > following
> >   - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
> >   - AMD MDB specific driver data
> >   - AMD MDB specific VSEC capability to retrieve the device DDR
> >     base address.
> >
> > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > ---
> > Changes in v10:
> > For Xilinx VSEC function kept only HDMA map format as Xilinx only
> > supports HDMA.
> >
> > Changes in v9:
> > Moved Xilinx specific VSEC capability functions under the vendor ID
> > condition.
> >
> > Changes in v8:
> > Changed the contant names to includer product vendor.
> > Moved the vendor specific code to vendor specific functions.
> >
> > Changes in v7:
> > Introduced vendor specific functions to retrieve the vsec data.
> >
> > Changes in v6:
> > Included "sizes.h" header and used the appropriate definitions instead
> > of constants.
> >
> > Changes in v5:
> > Added the definitions for Xilinx specific VSEC header id, revision,
> > and register offsets.
> > Corrected the error type when no physical offset found for device side
> > memory.
> > Corrected the order of variables.
> >
> > Changes in v4:
> > Configured 8 read and 8 write channels for Xilinx vendor Added checks
> > to validate vendor ID for vendor specific vsec id.
> > Added Xilinx specific vendor id for vsec specific to Xilinx Added the
> > LL and data region offsets, size as input params to function
> > dw_edma_set_chan_region_offset().
> > Moved the LL and data region offsets assignment to function for Xilinx
> > specific case.
> > Corrected comments.
> >
> > Changes in v3:
> > Corrected a typo when assigning AMD (Xilinx) vsec id macro and
> > condition check.
> >
> > Changes in v2:
> > Reverted the devmem_phys_off type to u64.
> > Renamed the function appropriately to suit the functionality for
> > setting the LL & data region offsets.
> >
> > Changes in v1:
> > Removed the pci device id from pci_ids.h file.
> > Added the vendor id macro as per the suggested method.
> > Changed the type of the newly added devmem_phys_off variable.
> > Added to logic to assign offsets for LL and data region blocks in case
> > more number of channels are enabled than given in amd_mdb_data struct.
> > ---
> >  drivers/dma/dw-edma/dw-edma-pcie.c | 190
> > ++++++++++++++++++++++++++---
> >  1 file changed, 176 insertions(+), 14 deletions(-)
> >
> ...
> >
> > +static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > +                                          struct dw_edma_pcie_data
> > +*pdata) {
> > +     u32 val, map;
> > +     u16 vsec;
> > +     u64 off;
> > +
> > +     pdata->devmem_phys_off =3D DW_PCIE_XILINX_MDB_INVALID_ADDR;
> > +
> > +     vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> > +                                     DW_PCIE_XILINX_MDB_VSEC_DMA_ID);
> > +     if (!vsec)
> > +             return;
> > +
> > +     pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
> > +     if (PCI_VNDR_HEADER_REV(val) !=3D 0x00 ||
> > +         PCI_VNDR_HEADER_LEN(val) !=3D 0x18)
> > +             return;
> > +
> > +     pci_dbg(pdev, "Detected Xilinx PCIe Vendor-Specific Extended Capa=
bility
> DMA\n");
> > +     pci_read_config_dword(pdev, vsec + 0x8, &val);
> > +     map =3D FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_MAP, val);
> > +     if (map !=3D EDMA_MF_HDMA_NATIVE)
> > +             return;
> > +
> > +     pdata->mf =3D map;
> > +     pdata->rg.bar =3D FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR,
> val);
> > +
> > +     pci_read_config_dword(pdev, vsec + 0xc, &val);
> > +     pdata->wr_ch_cnt =3D min_t(u16, pdata->wr_ch_cnt,
> > +                              FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR=
_CH,
> val));
> > +     pdata->rd_ch_cnt =3D min_t(u16, pdata->rd_ch_cnt,
> > +
> > + FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH, val));
>
> In https://lore.kernel.org/all/20251119224140.8616-1-
> david.laight.linux@gmail.com/
>
> suggest direct use min()
>
> Frank

Thank you Frank, this will be updated in the next revision.
- Devendra

> > +
> > +     pci_read_config_dword(pdev, vsec + 0x14, &val);
> > +     off =3D val;
> > +     pci_read_config_dword(pdev, vsec + 0x10, &val);
> > +     off <<=3D 32;
> > +     off |=3D val;
> > +     pdata->rg.off =3D off;
> > +
> > +     vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> > +                                     DW_PCIE_XILINX_MDB_VSEC_ID);
> > +     if (!vsec)
> > +             return;
> > +
> > +     pci_read_config_dword(pdev,
> > +                           vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HI=
GH,
> > +                           &val);
> > +     off =3D val;
> > +     pci_read_config_dword(pdev,
> > +                           vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LO=
W,
> > +                           &val);
> > +     off <<=3D 32;
> > +     off |=3D val;
> > +     pdata->devmem_phys_off =3D off;
> > +}
> > +
> >  static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >                             const struct pci_device_id *pid)  { @@
> > -184,7 +322,29 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >        * Tries to find if exists a PCIe Vendor-Specific Extended Capabi=
lity
> >        * for the DMA, if one exists, then reconfigures it.
> >        */
> > -     dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
> > +     dw_edma_pcie_get_synopsys_dma_data(pdev, vsec_data);
> > +
> > +     if (pdev->vendor =3D=3D PCI_VENDOR_ID_XILINX) {
> > +             dw_edma_pcie_get_xilinx_dma_data(pdev, vsec_data);
> > +
> > +             /*
> > +              * There is no valid address found for the LL memory
> > +              * space on the device side.
> > +              */
> > +             if (vsec_data->devmem_phys_off =3D=3D
> DW_PCIE_XILINX_MDB_INVALID_ADDR)
> > +                     return -ENOMEM;
> > +
> > +             /*
> > +              * Configure the channel LL and data blocks if number of
> > +              * channels enabled in VSEC capability are more than the
> > +              * channels configured in xilinx_mdb_data.
> > +              */
> > +             dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> > +                                            DW_PCIE_XILINX_MDB_LL_OFF_=
GAP,
> > +                                            DW_PCIE_XILINX_MDB_LL_SIZE=
,
> > +                                            DW_PCIE_XILINX_MDB_DT_OFF_=
GAP,
> > +                                            DW_PCIE_XILINX_MDB_DT_SIZE=
);
> > +     }
> >
> >       /* Mapping PCI BAR regions */
> >       mask =3D BIT(vsec_data->rg.bar);
> > @@ -367,6 +527,8 @@ static void dw_edma_pcie_remove(struct pci_dev
> > *pdev)
> >
> >  static const struct pci_device_id dw_edma_pcie_id_table[] =3D {
> >       { PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
> > +     { PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
> > +       (kernel_ulong_t)&xilinx_mdb_data },
> >       { }
> >  };
> >  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> > --
> > 2.43.0
> >

