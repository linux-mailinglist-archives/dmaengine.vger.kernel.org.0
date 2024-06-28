Return-Path: <dmaengine+bounces-2580-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F023491B88E
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 09:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45372B2186A
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2024 07:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB7D143745;
	Fri, 28 Jun 2024 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N0npT9kh"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F3A13FD84;
	Fri, 28 Jun 2024 07:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719560229; cv=fail; b=DqnW29g/WER9M71YwMxHhlIbbLoO1/5RS8lqK9k4PDTj85eZQx+z3jb4yR4/ivo293BGJz+uuK9z79GOmVNLIJ51N1mGFBVnSzK/Ce+OJjtiBoTU+SOhrP4xCno+wwNPnLiVHt8oXd6Cc8YCy9birAUz+tSETC1LIJk7j/nYUGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719560229; c=relaxed/simple;
	bh=wCA59b4eyI5SSTZtLX9WUdtZdnT7PY9rkLy3GO44Ng4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ixO478SGglyhCh/sq4Ztg230wJ10v3d6t4e/v1EKowqGJmC/VIvYGqw3y5Y09kLW4F+nIbOBQLk5LrPVwCuhl9BmzE0EO3RmiJdvTUstSjhzWmuRmg9F+8ZsFAWugxX/hJmOxok3g/3Ilj0F/bTqNbi/DNFrhafhV1lwGwULw+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=N0npT9kh; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CN15VGNi9KORCzyjato6Yr9647ut0kmwfgjERZ5Y82wS0urxMcPNuzLD1zv8yHsqKJeol8p2HTEhfztj1aHUYxsDY7g1bKngID1cn9e89wCfqnATlij+6022WyqdJcJEeC8MWj1pVgILK+NxpvxS80sGOV9qI96uhLr2o9yO3VPEGDKl1qDKR5sTplrK34IbXDQwumaogphD4NhnDMjTv/B6XtafUyApnPlzfGZQ70e2Sd7TQ8Bw4UjiVCxC3wYAC9d5KXaPuk6gDKLeIK2LYJb+bJzZPLoroc9JnuBKcOVyiTkc/XUf0KkV5NOpSkB3Jsa51QoncCr9ETNrUhx5KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCA59b4eyI5SSTZtLX9WUdtZdnT7PY9rkLy3GO44Ng4=;
 b=QBmkeMKsPLguwCqSnohO0WxwctTOp0qXhy+QNnBmncCHlDATv/z25SjVBiVpxoX68silRZ2ZZwmnRxYAMBQ++U/xHWMudKPDRwa2Nitvv++6MUN4nemf+8uPt8RoWCwtaUYUU5CeGQs8oxhELUYvXo/fMIw7cIgVi3CbWB3Xv6vu093FvKgV2ZoL6uw7CVlVeTYUEXrcNndjVCvqgQ5GIz6j4PuYZO5hE8YLsROCc7BByQbSs59+w+49r/A6gXw2YAeds41iFivqt94hX2AMF242v1ZDr6o0mialu6fksYq3/nMZS1whjuiWCYaiZ2PLcP1BDPCGUgHSY5bc/hcizQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCA59b4eyI5SSTZtLX9WUdtZdnT7PY9rkLy3GO44Ng4=;
 b=N0npT9khum/5sFyt5zmVtZn+Z1bTeTEAX5iADr3MyecIU+3JpY4iQZJ4DugjLLOCVklVjazBEyCbVnuRoQBnMvF5Zp1mGE5dIfP57LlIRSNXQcnQpekPZQkfpjGoJ6wy56p3PCBwq8qjtw+Z78/ehXMC/udcn45pHZ/I80SUTUM=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by VE1PR04MB7213.eurprd04.prod.outlook.com (2603:10a6:800:1b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 07:37:04 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%5]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 07:37:03 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/2] dmaengine: fsl-edma: add edma src ID check at request
 channel
Thread-Topic: [PATCH v1 2/2] dmaengine: fsl-edma: add edma src ID check at
 request channel
Thread-Index: AQHayS34RhU6aT+HYUKp0N1jNl5CNw==
Date: Fri, 28 Jun 2024 07:37:03 +0000
Message-ID:
 <AS4PR04MB9386EB9D10BB4B1F1C8F9ABAE1D02@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20240621104932.4116137-1-joy.zou@nxp.com>
 <20240621104932.4116137-3-joy.zou@nxp.com> <Zn5m2Wadskni-4az@matsya>
In-Reply-To: <Zn5m2Wadskni-4az@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|VE1PR04MB7213:EE_
x-ms-office365-filtering-correlation-id: 9cbc7bc4-9825-4702-4f6d-08dc97451ada
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?MTZLOEd2dG9aRlo1cjErVlZTRGMyL3A3bXdFcFUvV24wY3JYVlJuejVVQ3p6?=
 =?gb2312?B?SlpEclZuV004WndPRTJ6ZnpOM21UY2xNaWlLb25kTXRWV1d5MDcraWZEZk9p?=
 =?gb2312?B?eng3TkJRbVpZY01VWE5DcnU2dUFhdFZBQzBqZ044ZFluTTlPOWJuV2YzVnZo?=
 =?gb2312?B?QTU3dWUxbk9zQ25oWnAzSHRMcTFVVERQUkRDdEVUV0FsYnpKNERZU3JFN3B5?=
 =?gb2312?B?alkyRzdZOXBpNlpiaE1Nc1NLUFREWEhpSmJDMVJSQU1IWENMaEZpVnJDK1Fx?=
 =?gb2312?B?c2YvRWd2emppRnExc2R0cWNpWStUOVk1T1RwMWMwYWtmSW9Bd3g4d1c3TzAw?=
 =?gb2312?B?ZGp4SWRQdDBNQVR3bnFINjh0ZndGeHQ4ZXN6TFJLOC81alAvdFlDdjdxWUl6?=
 =?gb2312?B?aGlGYWt1TzY4elVJTEFFSitPRW1QSjF0N2xsYUM0RHRXK09XNC90ZnRXV0Fh?=
 =?gb2312?B?UVpNZmZ1cTcyRTlKVTcvcmJzb1lTRTJLMWhTQWJpeW1qdytZcGV1OHNlRHNt?=
 =?gb2312?B?SlRSNFVzdkdOa1ZwVElBbTNjSlRieGlNNFdnaDd6ak1GK2JpQzJrb2VEQjds?=
 =?gb2312?B?RXJSQmlwTFhWc25aclM2dGtGQW5oTkNOQjYzM0xCSEJMZFVGWS9JcnpRVlo3?=
 =?gb2312?B?d2lwakdQZ0c0eGplWlVTMmgxaG1FUVVCUFc2b0tZcUZOb0tOTldPNmFIODly?=
 =?gb2312?B?b0tLR28yV0xoK01EdGVQeDdMaE1ndXJxZlN5Z1pXZS9RNFFPc0dMcHJhR3ZZ?=
 =?gb2312?B?bWRRbnB6aC82ejlDTkV1WFg2dmdVVHFaUUtIMWRxbVdWb1RmcnlFZFg4aWRx?=
 =?gb2312?B?Szg3RmZGTzhRWWkvK2I4bExnR0REbjRGOFBCL09QYXd3SCtXb3JDZGpubEdI?=
 =?gb2312?B?ekMzWUx6SmVrNFZlRk5UY1FZK2VvYmFMSzFDZytEK3luZU85K25iZVU4YlVU?=
 =?gb2312?B?ZjBldXpEWFRxTXhOVFJXRXhtbjRCTUprSlBhZWUxVlNpeng4Sjk4MCtvcXlO?=
 =?gb2312?B?NmJ2dkpKQ0JyUHZBL21yYUJuMzZGZUZOSWJqdDR0OXFNbGVTMGluMTR0dXNt?=
 =?gb2312?B?UVRmL1dBMkd1T2svZUp2SDRza1ZEZ1dZRFozdXY5NlJiRkxaQmdZaEdLTmM2?=
 =?gb2312?B?cG9IMnJjNUg3NjBpV3JnUktKam0wclh3cSswejFkQUt5bkJ2emJ1QjZ5Ukx5?=
 =?gb2312?B?RldBUGRHOWV4VFU2aDV0N2VLb1JhdkFaSThEVmhUSGhRdC9vY2VEWG04UHJ0?=
 =?gb2312?B?ZkhqY0l3YUcxYzRCdjJ2bVVzakRkd0kxZm9nMXlaT2pReVJGZXBOSVZ3bkhJ?=
 =?gb2312?B?eXlOVDR4dWdqTjBTZkV4aDJleE9SaURTbGhlMlJpSmNTYm5rUG1RNVFMdkRp?=
 =?gb2312?B?Znk3MGdiSmhaUmMxZlZyMnFaZGdRTzlZejJqKzZmQU84S2RvdEJHQkhaSTAx?=
 =?gb2312?B?NElZVytPMnNSYk40RWo5MENsYkpFbWR3ejlQd2xWU0VZK3diaWpUUXpKOGg2?=
 =?gb2312?B?T0Ird2FQd0xNa05jWUdseGljSlg4SEt4MUZCSjNJdzROUlI3MEFaeWZnYXpL?=
 =?gb2312?B?bnUxYkJ6NXJpNGlPT0VXdjJQemluWGI5MUcyZkExVUZoQWRzejV4T0h4NTYw?=
 =?gb2312?B?cC9RVVhZTmJvRGpiejFxeU81L05Sci9XR0c3UlI0NUZSa24vMjJoRko2QkdM?=
 =?gb2312?B?YnZIcHVwb2lsMUQvQzk5bkpGRnExZnFKTjhVQjc2eVg5YVlrZm54dVZiaE5q?=
 =?gb2312?B?WGNzeXFKVFhsbDhockVyM1ZUTWVscithN0hDZWN5Ny9VUEtWRXNhZDhEelU3?=
 =?gb2312?B?YzZOUzlKOU5HWXlRSEJzUWdyMmtyUEg1d0g1NUZldGEyM3FKUjF2M2Zuam5V?=
 =?gb2312?B?SThWSnM2RHFxMm9oOFY5WkVGRmxEendSZDhWQ1h0M2tCYUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?L2tWSVRVQ3ppQ3JWdi9mY0hJZDlzbTFLSFF2d1NORDNrODBlOVRBemJjcnRr?=
 =?gb2312?B?MFlVLzJtcW0wMWUyNUxPWGwrOG52dHkzb2dKZnhHV3krQXltWHpROWxuTjBE?=
 =?gb2312?B?U0d6NytGT1JDemREYUJnbmRiUlE0Q2ltMG5BMDdGbjNPRHVJanoyNkhMS09i?=
 =?gb2312?B?ejdCMVBRMEVXWDVaTVRSMW4rcnBYQWIrci9zR3ZaN3c2V3ozQmNtaHVUTFlk?=
 =?gb2312?B?dUhFYnNsNVpnZUVvMVk0a0FNUnFYZ3ZELzBFYTJ1S05KdUxxb0dsQkVtTk1p?=
 =?gb2312?B?d3JsdllpS0hXQmlad05CVFNjelpOZkxvZVFxTUFsVCtKK1R5UEJGR3cyMDBw?=
 =?gb2312?B?VWV2aGxkMThIZlpFUnZ3WTF6RDNhTlhlY0NJd1NJcnNuaVNTeDZISlpaRGNv?=
 =?gb2312?B?TG5RcWJZNXMyNFpxTzFiK1RMNHVHazVRakFQaE1XZ1cxZDRNOWNxTEkyV0hl?=
 =?gb2312?B?YXZRbVNrSllGUW9RMFE0MDJoV1RxTkJqcWM5eFllb0tTUk5MYytnTWc0Ymcv?=
 =?gb2312?B?QVFHVGNuaTBEbU9XZWE0bU5mWG5lTncvYXhpQTZjUCsyall2RGN4cC9qdmFT?=
 =?gb2312?B?blV3TUFObDlYanBGcG9IeDF2eU9JWkNYbjF6L0p5WVpNWDZXL0NBcmtpbnoz?=
 =?gb2312?B?eDhjaE9udkprQ0JYcDl3dm1jOVVUQks5Sit4V3J5TUQ1NVdvb3VqUUNiVUpN?=
 =?gb2312?B?VjZkRVN6SEcrZWpTMWVuTmhjSmt4Q3B5TzRyM0tzVndBcS9EU0NTay8rajRk?=
 =?gb2312?B?YnZGaFJvRWlLekkzMlBKOWZwcXlrN1JvQjEzK3pnc2E4YWZOQTFuQXkwVjBC?=
 =?gb2312?B?Uk5oRzhWQ1BYam1UZXZSSHovVHNKbnRoR3UrdVRJMXYyMXdYTGUyZWI5Y25a?=
 =?gb2312?B?aDM5RFFyeS80K1hBRytFblVsSzZZVXZxYjNXc3hZWUNrNmdnUjhnd2c4b3Fk?=
 =?gb2312?B?MHBtbm5UUmpyVC9Idm5pbDA0QllmZkU5MnFuQXBqdmJLdVVGamliaGVWUktH?=
 =?gb2312?B?NFpDeGY4Q21xTkxjeVNIdVowSjlKMEI2ZGhMN2I1Zmh2OVFtMmZZQ2hMMjl6?=
 =?gb2312?B?YzViL3J0cW9iQmJSMmhFMkZ6cVpqeHNJb2p4SllxSDdEa3NXUGpzTllhMU5h?=
 =?gb2312?B?QjlrODFsb3FNZWp0ZVBIeURsMWxNSkNvc2RDeUUyTUtLV0VQbVkwMTdPdHZm?=
 =?gb2312?B?UC84RktndkNUKzE1T2xDNnhZSFRVdUVEQWJMb0pYSHBDbVo4OUlEMzU3MHVV?=
 =?gb2312?B?SDBVejJmNDlsanM1QUt1Z1NGbWhuN0xIUitGbTlGUlptTm5GbGlyeVhHV2pm?=
 =?gb2312?B?SFBLL0FxZmN6aUo4MDNYQ1E1Q1BnVWtUZEVpR1NiRUM3ZzFVZ2g0RjVFQ05C?=
 =?gb2312?B?eU1ZeGVjTlZxc1lrYVVNb2FHNThUT09oQ1lzZDJncVV4UWZOUlBWMDI2cVVv?=
 =?gb2312?B?QUNyendQcFN6RnZ2VzhoUGhiZFJ1RUVWOGY3TjJWeDNrTXlOVjIzSldWaVFX?=
 =?gb2312?B?NVdDUHBseDMvZVlvZTNOQTdPdHZGRXZpU2hZZTRhTmYzUHZ4VVZrMVFmYTNz?=
 =?gb2312?B?dGhKNnowV0ZaVE8xMitOQUh4b1FwRDRJaDRMVDc0cllHMWdTcElqUkF6dVpE?=
 =?gb2312?B?OHFzZ0Eyb2JlbFV0TGNOVkovUEVwSUVjbXNoaE9YYUd0SCtwQVRlK1FMODVR?=
 =?gb2312?B?djFjSE5SSTRzTEFoUzQwMjFZWE1MN2crbVhtZzBXOVZuS3NiUEJ6U0syWVRt?=
 =?gb2312?B?SHU5ZVg0OTVOcHpHaERVZ0t4S2JaL1Fob1d1b1ZIK3YyZks2cjViNFpUbXRJ?=
 =?gb2312?B?aDVTRVZvT0JmQzR1bGFERTlBRStNMzNHSStSRCtjNXBMenBJSWZDVzVKbzV1?=
 =?gb2312?B?QjBJOCtNdlBCa2pKWkF1MTNwVkpmSm5iaCs5Z21QVnR0RW9vbko0MnRpUTdS?=
 =?gb2312?B?WlJRczF0a25LS3J1eTlSZkh5MmtYMXQ3ak80Z3ExR3lwSGZHMnJOTCs2M2hU?=
 =?gb2312?B?Q2F5VGxxRlNsSnJNUDZHZVJEdzh6NjJRNmc2N2pMYlRnNEszR3pxVFlGNWZQ?=
 =?gb2312?B?SkIyZnREdmVQRk1RTUJ6V2lLZUVIYlRkMGMvQzVvd3YyY3JkcVJqc2p6M2hK?=
 =?gb2312?Q?xS6I=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbc7bc4-9825-4702-4f6d-08dc97451ada
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 07:37:03.8759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7vX1LENWGfHbzb6Benrh6pyGNpSIhZ1wxEnjc03ZF+cEyPQUaTRySi69jMw5i+Bc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7213

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpbm9kIEtvdWwgPHZrb3Vs
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTE6jbUwjI4yNUgMTU6MzINCj4gVG86IEpveSBab3Ug
PGpveS56b3VAbnhwLmNvbT4NCj4gQ2M6IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsgaW14
QGxpc3RzLmxpbnV4LmRldjsNCj4gZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHYxIDIvMl0g
ZG1hZW5naW5lOiBmc2wtZWRtYTogYWRkIGVkbWEgc3JjIElEDQo+IGNoZWNrIGF0IHJlcXVlc3Qg
Y2hhbm5lbA0KIA0KPiBPbiAyMS0wNi0yNCwgMTg6NDksIEpveSBab3Ugd3JvdGU6DQo+ID4gQ2hl
Y2sgc3JjIElEIHRvIGRldGVjdCBtaXN1c2Ugb2Ygc2FtZSBzcmMgSUQgZm9yIG11bHRpcGxlIERN
QSBjaGFubmVscy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpveSBab3UgPGpveS56b3VAbnhw
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9kbWEvZnNsLWVkbWEtbWFpbi5jIHwgMjIgKysr
KysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygr
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2ZzbC1lZG1hLW1haW4uYyBiL2Ry
aXZlcnMvZG1hL2ZzbC1lZG1hLW1haW4uYw0KPiA+IGluZGV4IGQ0ZjI5ZWNlNjlmNS4uNDc5Mzlk
MDEwZTU5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZG1hL2ZzbC1lZG1hLW1haW4uYw0KPiA+
ICsrKyBiL2RyaXZlcnMvZG1hL2ZzbC1lZG1hLW1haW4uYw0KPiA+IEBAIC0xMDAsNiArMTAwLDIy
IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBmc2xfZWRtYV9pcnFfaGFuZGxlcihpbnQgaXJxLA0KPiB2
b2lkICpkZXZfaWQpDQo+ID4gICAgICAgcmV0dXJuIGZzbF9lZG1hX2Vycl9oYW5kbGVyKGlycSwg
ZGV2X2lkKTsgIH0NCj4gPg0KPiA+ICtzdGF0aWMgYm9vbCBmc2xfZWRtYV9zcmNpZF9pbl91c2Uo
c3RydWN0IGZzbF9lZG1hX2VuZ2luZSAqZnNsX2VkbWEsDQo+ID4gK3UzMiBzcmNpZCkgew0KPiA+
ICsgICAgIHN0cnVjdCBmc2xfZWRtYV9jaGFuICpmc2xfY2hhbjsNCj4gPiArICAgICBpbnQgaTsN
Cj4gPiArDQo+ID4gKyAgICAgZm9yIChpID0gMDsgaSA8IGZzbF9lZG1hLT5uX2NoYW5zOyBpKysp
IHsNCj4gPiArICAgICAgICAgICAgIGZzbF9jaGFuID0gJmZzbF9lZG1hLT5jaGFuc1tpXTsNCj4g
PiArDQo+ID4gKyAgICAgICAgICAgICBpZiAoZnNsX2NoYW4tPnNyY2lkICYmIHNyY2lkID09IGZz
bF9jaGFuLT5zcmNpZCkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKCZmc2xf
Y2hhbi0+cGRldi0+ZGV2LCAiVGhlIHNyY2lkIGlzDQo+ID4gKyB1c2luZyEgQ2FuJ3QgdXNlIHJl
cGVhdGx5LiIpOw0KPiANCj4gQmV0dGVyIG1lc3NhZ2Ugd291bGQgYmU6ICJUaGUgc3JjaWQgaXMg
aW4gdXNlLCBjYW50IHVzZSEiDQo+IA0KPiB3ZHl0Pw0KVGhhbmtzIHlvdXIgZm9yIGNvbW1lbnRz
IQ0KSXQncyBiZXR0ZXIuIFdpbGwgY2hhbmdlIGl0Lg0KQlINCkpveSBab3UNCg0K

