Return-Path: <dmaengine+bounces-7997-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B5DCED8B8
	for <lists+dmaengine@lfdr.de>; Fri, 02 Jan 2026 00:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26CCC3008883
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jan 2026 23:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397D526E179;
	Thu,  1 Jan 2026 23:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="e/EmysgX"
X-Original-To: dmaengine@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801C9186284;
	Thu,  1 Jan 2026 23:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767309668; cv=fail; b=kIQSQR3aFEa5D/aIE+rxMV0MLCYSqELvgySmcDSYOQJF23+qmuliq9AuTU57ksWktPkzmw59/xHtoyyrCvIQAEhqfcFRfLhMMQAMF8+70hVHoMUN7cNOLjffmcdd4hDfCkO+ENF4rbIIin86HUa8mXAM31Vk2cP9g6YAdWdDMuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767309668; c=relaxed/simple;
	bh=l4FHIXbZPj22mPC7eGDz/8cwDdayloE1vBUuKNhPQDI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mFCXZTWKYdfF3oAsi+pjW+qpwstgRS+NTEQMMNz28cwFRqqKvAMDpM28t+krVCNvXnHj8YIsS7MkRQzF+8ShCf8qGsb3E3MtOI+zzYDUNMOO6+4+DOnHTFhNUkdZiEUlDDC5/oq7567p6LnE7h4W4UubSb6Iz994Y2R5Ud/QAAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=e/EmysgX; arc=fail smtp.client-ip=52.101.48.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jK8Xnq/7QaEYuA6t1xNnG/lEw2XyGB0Ta2olfnkWNOrQnaj+g+L6b0pQW3nWLBKbZ4WIwiTnX8ooWVdYj9PJPOsYKoh5nu5+NE+Zoiu/YlPynakrj/Y5ig21KwCL5h2tlV3m/6hAEDUwZexHcM9O7VYAYvypxNWpg6rbKphmwUneuKnxpMAFVhi9ccOyPEyV/ihtC32BeLGUol5CDMXZN24mtjLzc2/6vZvnx1xBCD9HNS/uXDzcrt/5BB4/t9fu0VA2CFR8U+iS9/WUm7ZtXDRrEfYb9RsB0Fy6gOtsEXNZ4KNZCDehZmk2ailvfC0oDoSBmMWtC72uW7+XCS2+rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4FHIXbZPj22mPC7eGDz/8cwDdayloE1vBUuKNhPQDI=;
 b=MyJFjL6xJml3RRVduAyh9BdDS/Uh3pkgE6bgQ12AvqV0XKhuRPu0RrfvM+hvCb+rReohF0ciK8Ix6VjqWDOa284mOojbOe0yRWTNRh4+Iwu3HJ3rR4OX4IEcpx+7yNcafIkD5UjjcTeNTcUh/eCefB6dKVYBCbQnHAT7RTIWCaywSNmXEF/AXb9p+9yQmSpuM/1KxEl9BLY8abcM66ehtvKtrRbrCZTK9GHV8xYoQ4AztyCYMzprNlqaddtGT8OH8V7c+L6rQFzjRR+HOyk88YP4eI8tIyQLPjOn6MjZ2IFR9woyORkpXvMMBzjrWlMJoFyDEE/WG91mjOwlG3ibtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4FHIXbZPj22mPC7eGDz/8cwDdayloE1vBUuKNhPQDI=;
 b=e/EmysgXXTcwZtHYU88XM2tbvvijTBQv67miNjQJz4Cq0EjfSr4pQh3QDQ2R/jtC3Tg591gZTWViEN7b0d9UBRfqD9h+fE0x8+U0GnrU9Ej9ZYf0WYZkVC864hEMgg4DfXvr3tg3aJ8ZmGnBIMoMC7eZ4zRQ+JGR6tHmIYX5qcRGb/N7+us9PIjNY166G2bjdMXx5TebjInv+qPGodx9tklkKgR2FSS8waguy2omJbEbAF3jUlYcEmQTu4phHF0EeelVTiSSELJDdUFiShgBk+p7ZcC1mk7vInyqC3+nRvnG9VBUBLkSWydTcR2XasAMcbR/oxkLVa8JJE5ZuCIK0Q==
Received: from DS4PR03MB8447.namprd03.prod.outlook.com (2603:10b6:8:322::12)
 by LV8PR03MB7351.namprd03.prod.outlook.com (2603:10b6:408:189::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Thu, 1 Jan
 2026 23:21:00 +0000
Received: from DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a]) by DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a%2]) with mapi id 15.20.9478.004; Thu, 1 Jan 2026
 23:20:59 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Vinod Koul <vkoul@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: (subset) [PATCH v5 0/2] Add Agilex5 AXI DMA support
Thread-Topic: (subset) [PATCH v5 0/2] Add Agilex5 AXI DMA support
Thread-Index: AQHceHYVuj9qoil1mUKOVq/tGE0YGbU9mtsAgABey4A=
Date: Thu, 1 Jan 2026 23:20:59 +0000
Message-ID: <7fc74327-a589-462c-91eb-53475c60eb59@altera.com>
References: <cover.1766966955.git.khairul.anuar.romli@altera.com>
 <176728930288.239406.12362948217259379016.b4-ty@kernel.org>
In-Reply-To: <176728930288.239406.12362948217259379016.b4-ty@kernel.org>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PR03MB8447:EE_|LV8PR03MB7351:EE_
x-ms-office365-filtering-correlation-id: 6bbd0d84-824c-4b36-7aed-08de498c6c9a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NWdiSFhJcEdPcmhrcVdMYVd4RXpGelJSL0NybEFHdVFIeUk0UGlweVZKUVNQ?=
 =?utf-8?B?NkNGVUcvYjRNOUVaTGNkZytZbndXNlQvbGJLMUNrMkNQNlMvUCtYR1NSOVV5?=
 =?utf-8?B?MDVDR3kwSTYwanR4bjY4cWVVREJoQkpudXBpOTlPVHdyL21GMHhpSjBlOGEr?=
 =?utf-8?B?UW15dEpaSEpMejRFKzE5MXZqY3lZTExtU3pTN0hMZHFDOFJoZ0tydmh6MHZk?=
 =?utf-8?B?OFc2a2VyclNLMC9QNmcyRk1Kemk0T1ZzTzBYNzBKS29UMWVXZWJtVWNPTmta?=
 =?utf-8?B?UFplT3pvYjRMaUIvZWVSWWk1eFhNdWNpVUlzMnJyNTRVbEJKNmNXNFM1dGJU?=
 =?utf-8?B?ZzBTRlpsSHVFY0VmKzhRN3pwODVxblhLOFlLOUZ3MEhxSVhoSEpXd2NhT3dw?=
 =?utf-8?B?R3VTMi8zV3gyeFRiV1hZbDFJOXE3aGRZVHRLTkt4alZqckVTb3lOZVJJbCt6?=
 =?utf-8?B?cXVMREhVZFNmaXNCSTZIMlBGSmhGYlF1bzFDV3FhRGg0VmlSb3d5WXBGS0dH?=
 =?utf-8?B?QVlqZHFJZTJQYzhyaGNua0xRRFdMK1dmT3Y2U2ZwQVF5dWRGcURVZ2FZVkZ3?=
 =?utf-8?B?OXM2ajB4VmNsUlBNMXFXdmZ1MXhXSi9ZRFcyWTJldkVLRThBUm5MZVpxR1gy?=
 =?utf-8?B?YVdFMTh4anh0emJ6OE1LcEYvbVMzaTc0bEVhMnpPbEVVbUkyNS9iSVdKcnFB?=
 =?utf-8?B?enB2dlZrSTBTKzgxRFBpcng4VDBBOXgxeGNEbUhkNVQ5TERNY2JFMld6L1dx?=
 =?utf-8?B?cUJBcDBCY0RWUzFuZlZRaGR4bUJqSTYrNEhicnhGaDFzN0FFK1VwUzZoS210?=
 =?utf-8?B?bUJHNW1uZ01VeWhDRHJYNVQ2Qm5LMVpGTURicFFZSDQ3bE1VZHFqMS9jdlpV?=
 =?utf-8?B?L2NwWWJvNEJhbHdUSlBRREJsNW5iRFlDMHRUK21aMjRSVlh4Rm4vM09Balh4?=
 =?utf-8?B?NzR4ZFdVNENOc3ZQeGxiU3Fvckd1TDlBOGFaVWVERzFDdUZzYXo0MTVWRGMy?=
 =?utf-8?B?OXFCZ3d6QlFmT0JDZXp6UGhPNFFXazgxemV5SUVleDF3UUE4NWNGSlRKbXZm?=
 =?utf-8?B?MlE1dW1DQ3dHMEtxdHcwdldCN3A5M2lRTDFka1NSRG5LZmhwZzZwaGdyQ1g3?=
 =?utf-8?B?Mk84blQvbDhROGdpREJQSjYvNmp2azk2RXdJMHRMT2FWRTlzV1g0Y2VJbUhm?=
 =?utf-8?B?TVVDWWtPSzJLWi9penBjcldPd3Z3VjVRYWlIRTFCamU5bWlsN3hBdlpHQ2tu?=
 =?utf-8?B?ajdYNmhZcWhPUUJyTjB6VVZSKzA3aDZCeWZqczlsR3QxY2xCZjAzR1BURXMz?=
 =?utf-8?B?NHlDSG5LMWFrMW01Q1d3WGRpNDhqOE9US256eUFtWXJzODJ4S3U4U01EUFhw?=
 =?utf-8?B?Y1NoMDhuNit0OEYyN2ovOVl0VXNGR0tGZGRLL3VUOHcyYms5aFJQWHUvWnA1?=
 =?utf-8?B?cGZTVjJrQVJUdEFqdDZ5b3YzczBWeFdBOTh1QW42d0t4NWpzMDVwdTFtT3RJ?=
 =?utf-8?B?WWp1Vm5wYVBPcUl6eEI5OVd3bkIyY3U4RmpkUGNkbEpOdVFveHU4REp1YWRB?=
 =?utf-8?B?OVp2WGxRSFNUMXBJUWtSWDFDYXB1azZ2RGpCR1lsMDkrbFdxdlpzMFhVUFlN?=
 =?utf-8?B?Y2tGL2pTUmswUFVlY2ozUGtzdndLZmVpbFUzYUIvU1dSaCtqUnA3REZwU2xp?=
 =?utf-8?B?ZVhKMzRKTFFidlNoUEdlN2Ruem5UNGRKLzh3NmJ4V0RscDJUMGQ1QzNWZ3pZ?=
 =?utf-8?B?VUh2QkFMbzZQeXlDN21FKzhZckEwRXp6bC8zalZ6RFdoSHFyRVBrN0tNbnRE?=
 =?utf-8?B?QkpHSlJKTmZ3WWh1TW44VmJQS2tPU0hobzFEYmQ0QVdabmU2a1pwSnN3QVUx?=
 =?utf-8?B?V2xlcFRpR0grNTlVRDdjeDUrazlxMkd4WXlicUtHelRJaG9aUW44QU5RWEth?=
 =?utf-8?B?clhTc0xJbVdHbG9Fc21HaVpIOUJCQUlLa1V0YmI0aEZjdHcweHZCYllxbU9D?=
 =?utf-8?B?b0VRZkd4OEl2Y3V0RjBYRkJsTFNMZjBXWGEvTU5NOXFoZnZPbC9VQVJ4dE1S?=
 =?utf-8?Q?bpIUGB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR03MB8447.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VUhRS3FWc3RIaUlHVHVtK2lma0RKSUZVeHJNNlB4QVdvY2FzK0FpNVJBMkNs?=
 =?utf-8?B?N2ZnZTBxc2tDMWFqd0ZXeUwrbjF0eFYyNGUrMGRXclVZTjc5ZFRodE9Uc3Vx?=
 =?utf-8?B?V0o2VnJmS1N2ZGZkS29wdG9QWDdwQ2VoV1FQK0Zrd0hrelh0R0lFYjdUZGJ2?=
 =?utf-8?B?UjdpM2RjTFZjRTJBa0ZjWkE1OHVCM1FPMGVaa0hjSmlPbGpLRWN2bTNhRHlJ?=
 =?utf-8?B?V2NzaGhHSUQ0ckdVUjJicVhQYUdDWWora3NMdEFDa3ZWd01NK3Fqek8zV0Fj?=
 =?utf-8?B?YzdsWTUzeFYwdnlvWUdUVjdYN3A0Mk56K1cwQU1wN1pqdmcvN29Yc0xOVFJZ?=
 =?utf-8?B?WmJiN3dERm5kemRiTWdJZlFWc0NjUzB3OEpsV01YV3hRakdYemZ3SW5iVEtz?=
 =?utf-8?B?RnpjbnQ3bVBTUUpDb0ljNTBoUnZXL1hhUmZZOXNqTkRxQnFQa25mVnlYL1hC?=
 =?utf-8?B?RjJYMlJMVW4zNWtRM0pOMjlrQ3Nlb0k5SmlRQm54elBYRitXam41K0NXVEtE?=
 =?utf-8?B?L3hqZTFKTTQxYzZHVk1HanJiUnB0NzluQ0MxeWJZQmN2ckR3NXZBN1BMN05F?=
 =?utf-8?B?QkgvMXhSclBLb2N5dkpLMTluWEpTeHQvdS9WMnU2OWJHMjl4Nll5cDBRYW9v?=
 =?utf-8?B?WS9QN3VyQnVQcXZleSt6U2VWUTN2SXVWK2w1Q2tONnZkb29xSWI1RzJNclN0?=
 =?utf-8?B?MG1QMThMNkVwVFVkQ2FnSHNTTG5MWkdTZFdXMi8yZU10d2hTNkZ4RUVuNThQ?=
 =?utf-8?B?cWlidDJpUFNORzRXaExjVDc4bEZYb3lWMHFiVmhXbXQ2RWNxRGhURUJmTUd0?=
 =?utf-8?B?KzBadmtHVTFyVGF3VVBBTTZISlZmVk5Mc3NNYWhmdmUwS2g2VDJvZzYxRVM1?=
 =?utf-8?B?VGNyWXFLblo0SnZhcitsK2lGajdaZFVXdXptQitPTUpTUGFQKzBQZ256Ni9D?=
 =?utf-8?B?TEhIMDREV3RMVXdxNnBJQUx1OEcxVEo4cmNOc1JiaXRGL0xoVk15dGlZQ0FS?=
 =?utf-8?B?d1Zsb0gvN0daMTlyL3BrSXdiTTFjczFJdy9uRXhFVlJ1TFJYVkJPK1h3UCt3?=
 =?utf-8?B?RFVYWjJGaE9NVWtmRGdKeTVTWDZwSWJRM29Jb05Nc3gwcFJaeFhQcGs4N3B3?=
 =?utf-8?B?WkNmc0htWVhwNzNpcEVNaE9HVnRRM0NNL2UvUld6UnY1TWtjR3FVZ2VnQTRq?=
 =?utf-8?B?U29rV1JHMkZOemUzU1dmWWhGYWsvazNrYmp1R3V6NUFZZ3RpV0FGcGorREox?=
 =?utf-8?B?ZHdWZjE1RFYzcGNiSEd4TlVwYWlXc0VSSXV0U0dwWnVMRTRGQ1BqN3Q5REFQ?=
 =?utf-8?B?Zmg1TXgvM2xZUDFwTWJ5WmdiM2NqRmtkelRvNUxScnhodEV2RTdjNm9FVENZ?=
 =?utf-8?B?YTV3dGthQlJvQVUrdXB0emV0UTIrV2pvNjVHTHZTNzFwbGdlY3BUOUN6Tmdp?=
 =?utf-8?B?bEpENm1TNWhGK2J2aytXNWwrSTkxV0pzUUlBdVUyMCtvblY0Tzk2d29GSmhR?=
 =?utf-8?B?Nm8xZURQbUpwVUphT0czeUVranhNeDlmd01xTFhtQU1xd3B6T3ZPZ3hpTDNa?=
 =?utf-8?B?SjU5ZXR3L241MFBlS2E1eC9UdXprUVRKcnptNFJKdTZMRUdTa1l1ZjkyZjBI?=
 =?utf-8?B?Z3JFdldMMDZ5dXY4alFSdFI1RnBFRUFScjRPN1o0empQL2VPUVIwMU5MTExy?=
 =?utf-8?B?Um5NeUVoUU15UUQ2QWlYQ3NlOXJRcXVpclZVeXRsbCtXWFFvREsvTTUrZ0xG?=
 =?utf-8?B?amhycEtjMnh4YWEzM213Q2k1UDJYVmpPOHVJelJTMjFEYTEvNnBickQyRlp4?=
 =?utf-8?B?RnZmUy8wYmZjandieVllTEFsWElkMURpdjFXMmZPN09TaFRyekxXVUtrcWsr?=
 =?utf-8?B?c01paVg4L09SY1ZhbTkva2V1TU5TZXBzUlVocFQyeVhZc1VwVUFuY284aGJR?=
 =?utf-8?B?SzZlZFFKNDZnMUx4VlVtYTVBNnkyL3UxM0Z5bWgrNjZYMnhJZTVOS1RwbW95?=
 =?utf-8?B?Y0Q4V3YxV1VSZm85NHJOSzdpODJCSDFMREU4MmsvajVHY3NIWTZXUHgxblB1?=
 =?utf-8?B?V21yRkJHMGZzdkR3Q0p3QUR2RFZHNldUdWlFWkxmMmxNN3lVNE1qTFRGYUEx?=
 =?utf-8?B?VkZiS2ZaZ0NoOFl1MC9Tak9ZTWI0SVRPSTZPcmQ0Zit6M1d4WmFjVmEwKzNv?=
 =?utf-8?B?S0tBQjJwcGQ1bU84REtwSVlsQWRQU3hMRVEwaS9TNGN5UWpGTFdsN2pNbk1J?=
 =?utf-8?B?bWZ3KzZYUmMrTmFXOTRHamlReVBoOE9MSlEyWXcwYitLdVJPL0pwTjkyOFNu?=
 =?utf-8?B?bEZHN3VndTd1cGsvbFRBZjVmckExdjVBTDhpalFpMTdhcjNlVEFJeHZLQ0Vy?=
 =?utf-8?Q?1daSpiwbiPYmLdDAGFPQuPvULogKcsdDdv8A2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5199DDDF8A28084BBBA427CC06C01966@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PR03MB8447.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bbd0d84-824c-4b36-7aed-08de498c6c9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jan 2026 23:20:59.9134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2DZsiFLrzBUigLPV3bdgbHN9vm8FzBkZRu7OJJ+N+AAYkQQD6lV8+MvwkfnZ5R2u7xUTf3Hp1UkhjuDicApWZtdJOjLK4AfqmhXZgBfoCoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB7351

T24gMi8xLzIwMjYgMTo0MSBhbSwgVmlub2QgS291bCB3cm90ZToNCj4gDQo+IE9uIE1vbiwgMjkg
RGVjIDIwMjUgMTE6NDk6MDAgKzA4MDAsIEtoYWlydWwgQW51YXIgUm9tbGkgd3JvdGU6DQo+PiBU
aGlzIHNlcmllcyBpbnRyb2R1Y2VzIHN1cHBvcnQgZm9yIEFnaWxleDUgU29DIGluIHRoZSBTeW5v
cHN5cyBEZXNpZ25XYXJlDQo+PiBBWEkgRE1BIGJpbmRpbmcgYW5kIHVwZGF0ZXMgdGhlIGRldmlj
ZSB0cmVlIHRvIHVzZSB0aGUgcGxhdGZvcm0tc3BlY2lmaWMNCj4+IGNvbXBhdGlibGUgc3RyaW5n
Lg0KPj4NCj4+IFRoZSBBZ2lsZXg1IG9ubHkgaGFzIDQwLWJpdCBETUEgYWRkcmVzc2FibGUgYml0
IGluc3RlYWQgb2YgNjQtYml0LiBIZW5jZSwNCj4+IHRoaXMgc3BlY2lmaWMgYWRkaXRpb24gd2ls
bCBlbmFibGUgZHJpdmVyIHRvIGhhbmRsZSB0aGlzIGxpbWl0YXRpb24uDQo+Pg0KPj4gWy4uLl0N
Cj4gDQo+IEFwcGxpZWQsIHRoYW5rcyENCj4gDQo+IFsxLzJdIGR0LWJpbmRpbmdzOiBkbWE6IHNu
cHMsZHctYXhpLWRtYWM6IEFkZCBjb21wYXRpYmxlIHN0cmluZyBmb3IgQWdpbGV4NQ0KPiAgICAg
ICAgY29tbWl0OiAwYTY5NDY2NDRmMGQxMTUxZDMxMjEyODIwNDk3ZTFhNDlmZTFhMGE2DQo+IA0K
PiBCZXN0IHJlZ2FyZHMsDQoNClRoYW5rIHlvdSBzbyBtdWNoIGZvciBnZXR0aW5nIHRoaXMgcGF0
Y2ggc2VyaWVzIHJldmlld2VkIGFuZCBhY2NlcHRlZC4NCg0KUmVnYXJkcywNCktoYWlydWwNCg==

