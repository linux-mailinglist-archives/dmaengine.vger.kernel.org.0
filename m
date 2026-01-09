Return-Path: <dmaengine+bounces-8148-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBC2D0AE5C
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 16:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D790300F704
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 15:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E80320A0B;
	Fri,  9 Jan 2026 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WjuL6Rdj"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010017.outbound.protection.outlook.com [52.101.69.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7128135C190;
	Fri,  9 Jan 2026 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972535; cv=fail; b=NStrd+qMImMOaU17In3YKvLVYW5dC/9zTtm0zzD1w8NKOloMQBfGV/DQvkrblHSMjwazbvfoa20+/VH0i9nk1XTbE9Y3vSavNrOqanifewzhpBTt8Jaj3MmiS5f6RqFSVIJg/bbINvBrkldPTUMEjA3DIxcqnk/JGBYB2PU4VaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972535; c=relaxed/simple;
	bh=BO7ZpmsI/Sckwtp+7i3aUyd0xlDerMDxffVv9zYzRGo=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=jrR4nDWWUEOyYk1I2PnGUUCS1rzXFGi8ajrVtewtXDE2425KFHUGigCyUhqLym9ajkAEIorjzzpc6hKNQWETRJ3i44RtOcCjvI4yjNTHCPplocNc92ONIBEfgz8jx1SXJJ12QvAy5sUqmgwiOmi9z7fys1Kw0zdadoBzAddFWuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WjuL6Rdj; arc=fail smtp.client-ip=52.101.69.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1qclRn8K1Bklbq5hiWeYeKtuFtABD7f7v0YjroI3DN/sOO3ITdJsfMzxCgXxIf7Uld+o4oGfs95vnxNU+LGxmkT6hAvQjpnsdRPGctDX5FfpQckDwYtvvVIN9cIKyxOhhR37u3y2G4Za45olIen8UTa1ZAl28Ds/YsZqD1Q2GASM6Ta6REX23JI/lKvARDqY4Xhd+Uh/jb5ljN/q/MHbE6DM7DTR1gmO4lZjJNOAA2yQwKadZZJviHDGB+kV+LKnOI6EfjU7yv3yDMHdjZyDvfhuobnESNqP5bMn4vsjKwrRYs2WEAYxmCRBBu0H3EibJ4YC6Pa80nmgL65eGrlFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Eb3znxhwbjgu3PvcF24fYrUGJ/0UxiUYyIWEJ9zFRk=;
 b=BaWkRr1FqhS5I0aD/RB0KKhiX9waNs3MiwABqBpxbNlMXhtyz3mDvN2NA75WnyTNGqbtylYtJoi83mOq4N5VD7dufQa0ZMplQmdEpQMXVxm448CLrirFK2X1E0XYQLuSyJ4nTBVvQzLGqIORpgC8ExVb1sBqVvvzfuXbP3b2LpL9tCXE3mXuVL7qfj6uOwyLX/SXerpmcBBwo4OSzI5CwPQCLTW/B0iB2Rb7fXbn0PaGMBNscQnHIvkg+jC4yo77bGcrhLlNNQduJVkDS/y0z9OMGuJJ1wUYmEVMJA8pNp7IHjz2cpl5H0WmAwWWdaeNrj1m1uCFAu0Nob90NAxihQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Eb3znxhwbjgu3PvcF24fYrUGJ/0UxiUYyIWEJ9zFRk=;
 b=WjuL6RdjbqoLt+aDxzgcGo6en2iAj0HClQsJ9TA/HkKDxoBiO8yXhcmajRoBV76RgzjUXeu8/a3qmU++FB2KtvmPGf8z9geQNxu3TC4jJ6JSOpXBYfYC1dPqzqvd0HpwiZpyiIWD/6SDEUf3CgZj0GX37XGnmnVCf0QzzqN9eXd07PzGCTjEXritdIX5ANVZKUTPNXY+Dblx5hanG8YXEY/7O83lSmwldnu8t/kjPmUtWFJ+3eS81Tv648mP2IjfleYEY81hf0R4yVJBFjOMtBUSnKJQ9nlLhSd7q+TQH187B87PHsryPQhED7H77RaAcaJr0dKYSrknoOU2F9Yelw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
 by AS8PR04MB8261.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 15:28:49 +0000
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5]) by PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5%3]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 15:28:49 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 00/11] dmaengine: dw-edma: flatten desc structions and
 simple code
Date: Fri, 09 Jan 2026 10:28:20 -0500
Message-Id: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJQeYWkC/z3M0QrCIBTG8VcZ5zrj6FrMrnqPGGF6bMKmQ0MWw
 3fPBnX5//j4bZAoOkpwaTaIlF1ywdcQhwb0qPyTmDO1QaDouOCckZnVfZoYSjw9FPbSIof6XiJ
 Zt+7Sbag9uvQK8b3DmX/XnyH+RuYMmdX9uTXSdlq1V78uRx1mGEopH5eXYtucAAAA
X-Change-ID: 20251211-edma_ll-0904ba089f01
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767972522; l=6753;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=BO7ZpmsI/Sckwtp+7i3aUyd0xlDerMDxffVv9zYzRGo=;
 b=GyINm52kv5427Png1/NTshrxTGgMLYa0Z4bg5+y/XyB0tEjp1kJN8UKOJtf3fgelsjRCtMM5/
 BWKXk1DbHiGBu/13K3IsGttBQzXANHf+85nHWej/q24csDEW+6x7BJl
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR01CA0069.prod.exchangelabs.com (2603:10b6:a03:94::46)
 To PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8957:EE_|AS8PR04MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: eafcc505-1718-4282-ca75-08de4f93c827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHV5NDdpOEIrTSs3M0gyUjBmYkhVdW9VdGJnMVNBU3U3UXFGaTFYeXRldndM?=
 =?utf-8?B?UTBLVU9yRTFNRHl4MnFCL2txUVNUekRhUDFsdHlyMmdLRGRzZU9aeUdEU29s?=
 =?utf-8?B?QTJRT0xxMEJwOU1zNVMzam1KWXlkL0t0ZEZxcUtVTXhqaTRLQzZ6Wm1Cc2Na?=
 =?utf-8?B?SXFDQWo3ZklocE5GdFBDL0E1M3pkODc2dWE0NnVtY2N4dFpKYTFRWW1nTlMv?=
 =?utf-8?B?TGF4M0hQVEZlNTRwSFVld1Nna1FPL1A5TzE2eGJTdUVRSU8vOE9ya0dlNkxw?=
 =?utf-8?B?Zk1Mc2JFMGlYUTk5VnZYSjZoLy81NEU5U1l6MDR3ZDYwVkg3RXZ4YnRIa0hm?=
 =?utf-8?B?cUVtM0hXc0Fkbi9rdFg3enJSZlJSelhYTHVMaHVZSUdGeDU2NE5Wd2hIL3Fn?=
 =?utf-8?B?cG9tc1htMkhORjZLL1Y5ekdPNFBBUllybXdlR0k0OW1Jd3FGb2VvdVRsTjJ4?=
 =?utf-8?B?OERmSVVOM0V0RWtWMnVlVndOSjJPSUZ4cmIrdkx0empXWG9TZ2ZtanRFKy94?=
 =?utf-8?B?SHViVDgxRzhZU1FUODhOdDAxcWFzMUxJSFExSmNXZ3BMdmZZSnFKdVljaTlC?=
 =?utf-8?B?eTZueDNLZ1FmSUNnOWZvT2srOHptQmNoeXIvcUVRS0xURnlzdTVwZXFnVGl5?=
 =?utf-8?B?UDcyL29hVmQzcTRnV3dKV1NhRXp0SXBicXRkWlk0TFBnUlFibTgzdVZycjJV?=
 =?utf-8?B?aTdzS0tDWW9xNVRjZVVsRkcrWFdzNVhRNnVmdWQzV3R1NDE3eGw3ZUlUQUM3?=
 =?utf-8?B?QTFtNVBaOFVHTHk4LzRFNXE4MC8yTWJrbkUxeTV3ZmhpVFVKTnhTVlEyR2Ey?=
 =?utf-8?B?RzEvQW4ra09udlVFRFlPQktBOVB4ZGxPU0tsd2I2TERTSndTRjdza2VtUHJT?=
 =?utf-8?B?cmYrbFFhb0xDcGJQQk9FRjN5RGpaQVhTM3h3a29yNVI2RVhZNjJra2VOVnVi?=
 =?utf-8?B?NWxDYVpucXBkRy9zYTllclVCRXd6MC9kRjhDcDIwellTcFVzNjFXQWdWU3dY?=
 =?utf-8?B?bHdnZ01ic1NWVG9zdlhnVmlzSlFrZFg3b0t5QzBMM3lnbzFmTmQyS2VZbkI2?=
 =?utf-8?B?VUlXTVpBaW5UdHgzQ3p5OS9IU2Rvdk94eFhXWUtOWG5QeTRTVGV6S09LV0tk?=
 =?utf-8?B?cjhoMnZmczZZMFdGL3ZqTk5yNlQvYjdieEVaWTZUVHExcDBLTEFyckZpRnB3?=
 =?utf-8?B?OFdIQ05JVjc0dTVKR2R6QWpHK04wYi9VaUFpZjhIOTFKcEZrTTlNd3Y1amhO?=
 =?utf-8?B?YmNuRTdEbWxySlhZTDBodDZEL3E4TnFRSm5GNER4Y01XYmQ3aXNZOVl1YmhD?=
 =?utf-8?B?aTQ5RGhJNlptK3VWYzBhWkVObjA0UTRHcnJRUUg4RkhGNE5CTTZiNmt1Ymdv?=
 =?utf-8?B?TmJoTWJYSExzR2ZTbHBJS1BzMTFuTFVpQmF4RlhKdmJVVE9id3R5K2ZtL1Rq?=
 =?utf-8?B?ekxnQXA2OGtIdmJGc2N2VTdwNEFaaFJtbVpWSXNEeEZjak9qVEJGS0h2NTBZ?=
 =?utf-8?B?T1I4QTFjcTJLVHFabnRUTHJDS0VkbWJPRGFQenlOaDl1Vlo1em9WMTZmak5p?=
 =?utf-8?B?T1hNanFTZUZmL3dZQVBKWlFBWXhTeWN3L1laNFRKYmhXV1c5VURxSWxFRExt?=
 =?utf-8?B?WVlGNzE5Z1RSSWNLVkExU1BXTURxVWJhVThCZ2g2K0w5ZUxkWVFpaXFZRmov?=
 =?utf-8?B?eDBpMWE0NXQwZENTT1BOUTVNdDBhNE1xdi80YVdPN3ZnS3E1djY1eDA2VXZP?=
 =?utf-8?B?YXJwZUtmOVk3NmhYN3hqUTkwQjFSZFpjZTNoazhRM3I4Z29YTFYxeWZmanpy?=
 =?utf-8?B?Ui9ma2xxbVVUMVhGV2lySW1XUFpjZldLOTA4aDFyenZYM2V1ankyWUpDc0sx?=
 =?utf-8?B?V1RneXJJQXZWTE9VcFl4MnV3dzdFZXg5WnRKbThmRk4yMWpCcHJWWHYyeXVP?=
 =?utf-8?B?TnJLYklDRGlqb2l3MWZwZGNBTVhxRzhjZHlMOHVoMzEvbnk3aUtFV3F4a1JG?=
 =?utf-8?B?VExsNnZ6TGNLQlJTa1d0NFhsNzJHdnI3NllCYWc4cDZRK1hrTkNJcVgwV2pH?=
 =?utf-8?B?dTlVMTNlL3YyRmZidWhsK0I3TmgrYzdobmt3NHZ5OW40K09MMjdteUJ6eC8z?=
 =?utf-8?Q?Tk6U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8957.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDhkQkQraUkvTTFpMVU4OFlaUGxaQ3l2OHVFUmdFb1ZZejVqNXBLWWhYZDNJ?=
 =?utf-8?B?QXNoWnpHajd1VmRMMThjVFZKNmVYczdLVXV5aGs5aHNDT1NObUovNXBJNko5?=
 =?utf-8?B?WUZIMEpVNys5ZmhENk51T1FXVjRXZVF3ZnI0NzdyaUwwT0c1Y2xKTmQ3WU03?=
 =?utf-8?B?alpSSTBqUUJGZ3hyYzltQXJicFk4dzJ0SGlVcUxpY0E3a3BpU3hUR0RESjZI?=
 =?utf-8?B?YkJ4WFlZeWpxNGMzekxWYk1lTldoL0Q1RktZMUxsb29aN2RNZW5qMjIwNVFs?=
 =?utf-8?B?Tko5R1BoUGJTM2ZpYURSYTZ2OVdpSWZBVnBRTHhSeWtrZ2NCSzA0ZFMyN0FC?=
 =?utf-8?B?N2U0RTBrSml2MU8vSUcyRDNrRVJtelR6NUx6dXExZm52cjdzbnU2Yks3QmdS?=
 =?utf-8?B?R1A2VlhXekhXQUZ2dWdXclBEVGw2aGlHbEFLSi9zanZhRWNyUlg1bjJRQkg2?=
 =?utf-8?B?aGVlSmk0Mjh0OThSVVBqRXphSThxQTVWQzRhVnBEdWwwQ0JBR2JVQXFWYmZa?=
 =?utf-8?B?bUNPbW5WV1RLZW5vUkQrbFAyVlFhOEtsa1NFbzdBQ2pzTGNoYmlDakxMOTVY?=
 =?utf-8?B?RC80MjdjcXhWRnFlT2x3TFcvVG8vVzVIVFhBQnZRaThRYVFGc1BoQmRJRkdl?=
 =?utf-8?B?Y1dsUzdmZTdmak9yUWJqakE2WERBdE0rZyt1eXI5elhzaExDdGx0ZWdIc3I5?=
 =?utf-8?B?WFRNZFNGL3pOdStMM0U5bVZlV29CTThaVXo0dmUrbm9XTGQyazA2SGNIbXNt?=
 =?utf-8?B?b0hiOTEyUFlCdTM5UGlHZ2FSQVdXOTdyNXd6dUdmS081YjNzbVFIUkNuNmZw?=
 =?utf-8?B?ZW5YelhReU9jYU8rcDQzczVRUlNUUFlJZjc1QmRON1hsbHpXWXJ2UUhWbEtK?=
 =?utf-8?B?R1VuWWNFUERGVHluMmhIdmtJQUNZeGxVeUtpcXNEek5OOXpRZGRxNWw3TUZv?=
 =?utf-8?B?Tk1sQnQzdk1UcExGWXlqM0ZYSGtzTG5hdzZ4d2IwaXhEcm40aUlZMFVUNUZF?=
 =?utf-8?B?MFIwM2V5dWhqV0hjR0hoZlltYkF0VXFXd3BKeTdNUjZBWmR5WGh0QWhMRW5k?=
 =?utf-8?B?dmMvMi9OWFBOK3J2SVRlclB3Q3U2ODllRU16d1IvVVE5c0F1eWl3dVFpS2or?=
 =?utf-8?B?dElEOTExMlNxYTkxOFRRSFcwSkZLdExnTzNpbEtyMG1QWUpsKzRNS2hnUGlM?=
 =?utf-8?B?THptYmZUSU91dUJtRm5rVngwSnJqaXFmNTRxTlB6amEwQSs3THZxK0UxSnlZ?=
 =?utf-8?B?NytxRnNHb2E2T0ZOU1BaTWZrSTduRXRDOXQ4K1dWWHVzYXczY2RGZXB4alpX?=
 =?utf-8?B?Y1N3NzhGcm01c0FRUU1VMVo1QTh1NENyUExGMGVUTkZJYjFJRy9JNXdtWG9B?=
 =?utf-8?B?eWtWaXZYZEtIVy85ZGoraW9qaHl5ZllGYzBRSC9DdmVXbkM4MjdXeHpiZXdM?=
 =?utf-8?B?c2t6UXFDUWpZWFJlaDIwMU5PdUhuaEhBV0owaDZqaGR5U1htTXJPL2RPOFFR?=
 =?utf-8?B?RlpVdG9pbzhCTU5DQmpweUE4TnVHYlptaW1zQmFJM0RQd1NGc2FoZFVTdjNF?=
 =?utf-8?B?ejJyeG10b20xQ0NZdEZ2YmJOZE93Y3dlS2tqcmRwVXd3R0hQQW1lZk1SVDBX?=
 =?utf-8?B?VTNhQTl5QklOZm9JeUpDUTVobWVtbVNXMDdNekU1Z2pKcDhjd0MyenoyT3dE?=
 =?utf-8?B?bU1ZZ0R3ZWtRY05hSlN6NlRMZ0tkcWd0R0dVUE1DZTNIVnorTnJkZkZMSWZD?=
 =?utf-8?B?Qm5wemJsNTQ4c2k1NXZxQTJ4NzJDVmtYQm1BcWZZam95T2VZdVRqQms5VUZi?=
 =?utf-8?B?TkI5OEN4SnRSMGNxZnU1dXl2dzFVODdicUY5cUx6eHFCM2VsdFE1cWoyQmdp?=
 =?utf-8?B?L0hDeXJhUHFkZWhxaTU4NWFUYnZZKzYvWG9VT3E5TzFUNjJGdnhidFJvSmJ0?=
 =?utf-8?B?aStrdDFSdGFBVDhraEczbTFVVmVhbFBXYkhrN1VVNXpreWFoNmZlMUpsTzVX?=
 =?utf-8?B?cklxZktTWlpBUEJ5NW1FTEVnSnRaZ1ZqK0NxNVI1alFYMUFFRlpPWnNqSWZD?=
 =?utf-8?B?Z3hvL2l3ZjhFYmtvYWVIWmRaUGFha2JObm9DcnNsZVA2QkF0QzF1V1FLK0xm?=
 =?utf-8?B?SDlpUEhQN29TYXVDNmZPbUxmNS9vTTZVbE54K0NWNHM1OUpyS1NjWUtRZHhZ?=
 =?utf-8?B?OXF1LzRkcWNBdWxNYUhNRkU2YUR5VW1EVWNZSm82QVg3U3BvNjN6UDVweHFq?=
 =?utf-8?B?cjF6bDduVjVXMUgxMHp0Ly91S2x0WEtBWEYxMFJhTWZxcWNOZ2N6Q3JucDlq?=
 =?utf-8?B?Ungrelh1Z3VCR3pmRng1UEFPdVpyWlEyN0NmOUVTTzNMeHI0Y2R0Zz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eafcc505-1718-4282-ca75-08de4f93c827
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8957.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 15:28:48.9396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wXVMyYhzn3jWacKwW3YCyWEj8IELovTal04QJFFK+qhezyt7XzjZyfcaLsAZFpLMZaO4Mxg0g+iz60BfkQKbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8261

This patch week depend on the below serise.
https://lore.kernel.org/imx/20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com/

Basic change

struct dw_edma_desc *desc
       └─ chunk list
            └─ burst list

To

struct dw_edma_desc *desc
            └─ burst[n]

And reduce at least 2 times kzalloc() for each dma descriptor create.

I only test eDMA part, not hardware test hdma part.

The finial goal is dymatic add DMA request when DMA running. So needn't
wait for irq for fetch next round DMA request.

This work is neccesary to for dymatic DMA request appending.

The post this part first to review and test firstly during working dymatic
DMA part.

performance is little bit better. Use NVME as EP function

Before

  Rnd read,    4KB,  QD=1, 1 job :  IOPS=6660, BW=26.0MiB/s (27.3MB/s)
  Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
  Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
  Rnd read,  128KB,  QD=1, 1 job :  IOPS=914, BW=114MiB/s (120MB/s)
  Rnd read,  128KB, QD=32, 1 job :  IOPS=1204, BW=151MiB/s (158MB/s)
  Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1255, BW=157MiB/s (165MB/s)
  Rnd read,  512KB,  QD=1, 1 job :  IOPS=248, BW=124MiB/s (131MB/s)
  Rnd read,  512KB, QD=32, 1 job :  IOPS=353, BW=177MiB/s (185MB/s)
  Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
  Rnd write,   4KB,  QD=1, 1 job :  IOPS=6241, BW=24.4MiB/s (25.6MB/s)
  Rnd write,   4KB, QD=32, 1 job :  IOPS=24.7k, BW=96.5MiB/s (101MB/s)
  Rnd write,   4KB, QD=32, 4 jobs:  IOPS=26.9k, BW=105MiB/s (110MB/s)
  Rnd write, 128KB,  QD=1, 1 job :  IOPS=780, BW=97.5MiB/s (102MB/s)
  Rnd write, 128KB, QD=32, 1 job :  IOPS=987, BW=123MiB/s (129MB/s)
  Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1021, BW=128MiB/s (134MB/s)
  Seq read,  128KB,  QD=1, 1 job :  IOPS=1190, BW=149MiB/s (156MB/s)
  Seq read,  128KB, QD=32, 1 job :  IOPS=1400, BW=175MiB/s (184MB/s)
  Seq read,  512KB,  QD=1, 1 job :  IOPS=243, BW=122MiB/s (128MB/s)
  Seq read,  512KB, QD=32, 1 job :  IOPS=355, BW=178MiB/s (186MB/s)
  Seq read,    1MB, QD=32, 1 job :  IOPS=191, BW=192MiB/s (201MB/s)
  Seq write, 128KB,  QD=1, 1 job :  IOPS=784, BW=98.1MiB/s (103MB/s)
  Seq write, 128KB, QD=32, 1 job :  IOPS=1030, BW=129MiB/s (135MB/s)
  Seq write, 512KB,  QD=1, 1 job :  IOPS=216, BW=108MiB/s (114MB/s)
  Seq write, 512KB, QD=32, 1 job :  IOPS=295, BW=148MiB/s (155MB/s)
  Seq write,   1MB, QD=32, 1 job :  IOPS=164, BW=165MiB/s (173MB/s)
  Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=250, BW=126MiB/s (132MB/s)
  IOPS=261, BW=132MiB/s (138MB/s

After
  Rnd read,    4KB,  QD=1, 1 job :  IOPS=6780, BW=26.5MiB/s (27.8MB/s)
  Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
  Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
  Rnd read,  128KB,  QD=1, 1 job :  IOPS=1188, BW=149MiB/s (156MB/s)
  Rnd read,  128KB, QD=32, 1 job :  IOPS=1440, BW=180MiB/s (189MB/s)
  Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1282, BW=160MiB/s (168MB/s)
  Rnd read,  512KB,  QD=1, 1 job :  IOPS=254, BW=127MiB/s (134MB/s)
  Rnd read,  512KB, QD=32, 1 job :  IOPS=354, BW=177MiB/s (186MB/s)
  Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
  Rnd write,   4KB,  QD=1, 1 job :  IOPS=6282, BW=24.5MiB/s (25.7MB/s)
  Rnd write,   4KB, QD=32, 1 job :  IOPS=24.9k, BW=97.5MiB/s (102MB/s)
  Rnd write,   4KB, QD=32, 4 jobs:  IOPS=27.4k, BW=107MiB/s (112MB/s)
  Rnd write, 128KB,  QD=1, 1 job :  IOPS=1098, BW=137MiB/s (144MB/s)
  Rnd write, 128KB, QD=32, 1 job :  IOPS=1195, BW=149MiB/s (157MB/s)
  Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1120, BW=140MiB/s (147MB/s)
  Seq read,  128KB,  QD=1, 1 job :  IOPS=936, BW=117MiB/s (123MB/s)
  Seq read,  128KB, QD=32, 1 job :  IOPS=1218, BW=152MiB/s (160MB/s)
  Seq read,  512KB,  QD=1, 1 job :  IOPS=301, BW=151MiB/s (158MB/s)
  Seq read,  512KB, QD=32, 1 job :  IOPS=360, BW=180MiB/s (189MB/s)
  Seq read,    1MB, QD=32, 1 job :  IOPS=193, BW=194MiB/s (203MB/s)
  Seq write, 128KB,  QD=1, 1 job :  IOPS=796, BW=99.5MiB/s (104MB/s)
  Seq write, 128KB, QD=32, 1 job :  IOPS=1019, BW=127MiB/s (134MB/s)
  Seq write, 512KB,  QD=1, 1 job :  IOPS=213, BW=107MiB/s (112MB/s)
  Seq write, 512KB, QD=32, 1 job :  IOPS=273, BW=137MiB/s (143MB/s)
  Seq write,   1MB, QD=32, 1 job :  IOPS=168, BW=168MiB/s (177MB/s)
  Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=255, BW=128MiB/s (134MB/s)
   IOPS=266, BW=135MiB/s (141MB/s)

To: Manivannan Sadhasivam <mani@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
To: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To: Kees Cook <kees@kernel.org>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
To: Manivannan Sadhasivam <mani@kernel.org>
To: Krzysztof Wilczyński <kwilczynski@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org
Cc: linux-nvme@lists.infradead.org
Cc: imx@lists.linux.dev

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- use 'eDMA' and 'HDMA' at commit message
- remove debug code.
- keep 'inline' to avoid build warning
- Link to v1: https://lore.kernel.org/r/20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com

---
Frank Li (11):
      dmaengine: dw-edma: Add spinlock to protect DONE_INT_MASK and ABORT_INT_MASK
      dmaengine: dw-edma: Move control field update of DMA link to the last step
      dmaengine: dw-edma: Add xfer_sz field to struct dw_edma_chunk
      dmaengine: dw-edma: Remove ll_max = -1 in dw_edma_channel_setup()
      dmaengine: dw-edma: Move ll_region from struct dw_edma_chunk to struct dw_edma_chan
      dmaengine: dw-edma: Pass down dw_edma_chan to reduce one level of indirection
      dmaengine: dw-edma: Add helper dw_(edma|hdma)_v0_core_ch_enable()
      dmaengine: dw-edma: Add callbacks to fill link list entries
      dmaengine: dw-edma: Use common dw_edma_core_start() for both eDMA and HDMA
      dmaengine: dw-edma: Use burst array instead of linked list
      dmaengine: dw-edma: Remove struct dw_edma_chunk

 drivers/dma/dw-edma/dw-edma-core.c    | 203 +++++++----------------------
 drivers/dma/dw-edma/dw-edma-core.h    |  64 +++++++---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 234 +++++++++++++++++-----------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 147 +++++++++++----------
 4 files changed, 292 insertions(+), 356 deletions(-)
---
base-commit: 5498240f25c3ccbd33af3197bec1578d678dc34d
change-id: 20251211-edma_ll-0904ba089f01

Best regards,
--
Frank Li <Frank.Li@nxp.com>


