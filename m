Return-Path: <dmaengine+bounces-11165-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9j/6DDNtIWoTGQEAu9opvQ
	(envelope-from <dmaengine+bounces-11165-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 14:18:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A8A63FCCC
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 14:18:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=gIdqqGih;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11165-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11165-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 905DF30AF6CC
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2026 12:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE24438FF2;
	Thu,  4 Jun 2026 12:12:59 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013032.outbound.protection.outlook.com [40.93.196.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AC0438FE3;
	Thu,  4 Jun 2026 12:12:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575178; cv=fail; b=f6QzxdE+wAnOCAn01wrBME9iMQMSMqzODS4EvZ2yG5bsX2UrQ1DQdbaoVfPfblwIj8zjRWQ7rCESo/M5v6LA8fgSK79BkT0gRWbMLIbnxRgFG5cdVAM1iN95pZVhgOAdocTQeBbGxwwBRfE9+mvifpQfnUWu+ZodMsTHo96m9pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575178; c=relaxed/simple;
	bh=ZaTrsu+O18THEMg7gdMQUzXW7Ai4WRF8DTkt5+kNOd0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P1kcdOVJu+ySxENu1mmd/3HV48k8TvguXYgupsO6KN7QSK+rfBEs+3ielsswmv6tKeKXx9Wqns1V5W2M4c59U1Z0762S/cwMLKEy59LY2hz7KzKZox+L4FJFUG+JN7yzIG6SALr3ajisuv77TLniRrOS62nwdSLi+lvgDUVE//4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gIdqqGih; arc=fail smtp.client-ip=40.93.196.32
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6TRjApHKhk6Rs9NfnacFsSaqlFnb6sZ3vJgIBgwjQn4Uu5P2lNNi54fapzwveiTz/rvRmX5Bxa+wbmwO7rr7HyV+QGNrBbRLalhfaz+vqX+I3qFs4T3/KkiUP91ADe87UmacBxMSuXPSbGswviTWOnN3KvhalCW8Awb20ebjwP4X7TRGcbtF8t4qQAOVDBeNAaltRf9H8Gk+3ZrpkHLrl5nufeOwiwIQfRflTRQDlRJK6cGhDOFKTsMT8sn4CVwpcgZmx28XdzrFJAwTEvNcTaJSUVRsIVP15HRwaD8gvdqGik/3+9DwSQsCkbv5ojduoO7s5xjaN4aC54QkdXevg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaTrsu+O18THEMg7gdMQUzXW7Ai4WRF8DTkt5+kNOd0=;
 b=YogjVuv2FiDyXVLp7i5PhGrtIgFoiZZloYDh2ZGaQg3Ux7/k1hzRbkPLWIm9c8oTT1OYvS5O42hTF3yKAr6zTMICardoeCz2vO+6U8ggzxoOB0+s6RGNTYtk5cqAVM2W2j8hID+9w4o9sSGAvjUVSczzHnKVhWrJCdCNi9S33zpcmdSpRY5Z2EgKf0jiImfCxBGdyctIEq4zvr65efLz0x0HqcULlAewXo7mcKNTABPkJaqevkKRmSCp+Dlekdd10yRrT1EIehj3hLuI+L4km1o4eJrnFdcT4rNXKIIMs+73gN9JHyj8VT81qfQx/RN9bEclo7TkxcZPll21jAskPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaTrsu+O18THEMg7gdMQUzXW7Ai4WRF8DTkt5+kNOd0=;
 b=gIdqqGihfacMJ8fqgkTEITSHSrEdSs6ePJSMdAtTiqxOek958Yuub1XIWKTg/cpzV9xOMqLoCJ4fIijzVW+V+7DMZx5vOVhhnrf3rvpJ7VDQsu7rYiHJIMzMZMV5MkXXD3IBAwQL3H6zfcEPxSgXUwDl4UGcdnNJRvpcAnRqGVM=
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by IA1PR12MB8494.namprd12.prod.outlook.com (2603:10b6:208:44c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 12:12:49 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 12:12:47 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v1] dmaengine: dw-edma: Add Xilinx CPM6-DMA DeviceID
Thread-Topic: [PATCH v1] dmaengine: dw-edma: Add Xilinx CPM6-DMA DeviceID
Thread-Index: AQHc82X6OzOMXJ0Kz0iYp8qveJQ9C7Ys6DwAgAFnk+A=
Date: Thu, 4 Jun 2026 12:12:47 +0000
Message-ID:
 <BL4PR12MB948277305F69CC4A87F0D1F695102@BL4PR12MB9482.namprd12.prod.outlook.com>
References: <20260603143158.3243500-1-devendra.verma@amd.com>
 <20260603144445.562521F00893@smtp.kernel.org>
In-Reply-To: <20260603144445.562521F00893@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-06-04T12:12:40.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR12MB9482:EE_|IA1PR12MB8494:EE_
x-ms-office365-filtering-correlation-id: bf08447c-56f9-4ccc-1da9-08dec232976a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|11063799006|4143699003|56012099006|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 aW3jnHc6GbZSx+fFsn4mmBtr3Q8s+8I4YXKXLicddbUtb4sFG9dk300htg0/ESJyNO7juIfvbH1c5zt4K+u5SKgWRU14zsH6SjGtqMDvxjDBGyHkUhFfU1STSwtx8HH77E4GnOHmf+E7On3MHgBFs+6FYh6h4RO8TxHtGd/qrtXFQQJjfr7sFncxP4CLxUuoiVu6yoQpkFnEC5Wv1UFwTs7Ugj6Bi8b8rn1WrbgG1kUvC+c0qcZ8Sedzn02V10+R5d15Tw+MrigdGyBBLzDvHncGzjhY2kuwidhxNh24xH4TXkFaiDdh8+0N5XY7WVlHVXZO6Ivy2Q4U1mhvjWn7+oLg9nE8NCXb8jdVpiBOwDGm3cJbKjqPsRlP03XCEL5TfjR3tviCxFElrjldnHJ097pU5t2N0xIC/1Funq9uKlgz8SfoiN5gtX4oHKjLDol4hYJZPrI7wOmetljKDtCYNIb0VWyXNFyLMF7cM+l8rd7suTlNd54k3lmamXPTLvuH0DiBKqujCYn5fInJfCWGRZapPZYinxkmlvy8CAPgU+irKX1naszfZcQeBcMsgEfxe8/ojflsVc5uOqHJmKgkd9Pm2mTH2wBWQxcdlq24WZSQUXHNw5SlWF+vuYYzvcd+QNkskoCYVlOd4b+2e7LN+ifFCH7VONK7QC6nqJM4Ac0WrBrFVrJEvvx4jxI9mvQ6GPr1vdnF58QIG9kqobkMaw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TzBRR1ZOblpndy84WVFwYUpsZEI1WEJoTDM3MDVDUDR3RytTK0hnbGxjU3pH?=
 =?utf-8?B?cGsreU5lM1NaaHU0cGVObUUzVDFCa1IvTHh5VTZicEQ1TG40ZlZIdE5XeENv?=
 =?utf-8?B?b1RLYmJNS3RjeG9IUmh3alVJaFNkekhnMjVTUXlZM0RlRUN1K0tycXdWb2Iv?=
 =?utf-8?B?enc5djRZdGZSdW1QSFhGZlhudmxSV1d5bHBXOFhWNHJrSW1DSmdDb2dlWFEx?=
 =?utf-8?B?YmpLdCtnQjd3cDlIMGQrL0RCZGlTQ3BicWxPWWhOWmRJYWNieXVLcWI5eEhk?=
 =?utf-8?B?UnZsRSs3ZlZBaExMMWZmZVRRMi9XYjR2NnFSSkY5TlpnQmxwWlp2SU0yMlNQ?=
 =?utf-8?B?REgwTVpLWVBNbHBlM1JQYTZCdE9nbWdyWTNGek1BQnI1SWJKaTJuTG1iMnE2?=
 =?utf-8?B?SERUbS8wSUxKSUprSWxaV05XOUl1UGpsWXc3S1haSFdYcVBqdVlhRXFzbkxw?=
 =?utf-8?B?T0dvdVZjdUJrUkErMjUrRzRQZEZGR3pwOG5XL2dldEFWQkVweTIrclNpZHJG?=
 =?utf-8?B?dkNvMldPVmxQRG0xUHdQbTBiQU1MTzNQSmZId1pQUThVdC92MjZJMWZsN0hY?=
 =?utf-8?B?TElWTGI3L1ZIVjI4TkVaeThONmFBeG5kdTRQSXlETVA4dUd0bWhvWjVzNVl0?=
 =?utf-8?B?VCtqaHlJMXFiZ3hLZ2R5S1dsT2NaUVlnUFRXdkl6dXFHK21XbWJTUWl4Rng3?=
 =?utf-8?B?NTNmV09ZVENLQm1FSEFNRm1oUDBqK1BJYUFPaHlQaFp2SkVkckZOVUt4eG4y?=
 =?utf-8?B?VGZ5MHRIUTBYcDNTWHhFYklqc0tUdWFqVzdIMjE0TDlhRXE4eTMyMWoxRldR?=
 =?utf-8?B?TXdvRVFkR3N0VGpWT2VFSEQ0aHAvOTgxOTh1SGdyVTFMcWZEeWh4ZHozVk8v?=
 =?utf-8?B?S0JMRHpVQU1PRjBOMkgxVzg4UXVMZ05wdWIyT0xjNDh1M0xCUG54Ui9IWmZ3?=
 =?utf-8?B?Zi9acEkvQnFGUmwvai9ia2U2ZzAwT1QvREs0Z05PakdobzYxZUhia2RPQkpM?=
 =?utf-8?B?QzUyRjhTR2h1Z2JwcW9lZWJncGZZc3BPdElYM29tY2hmWlRZQldITlAvdkt3?=
 =?utf-8?B?dloxLzZPa0x0NzRiWWdKemFYY3l5SnFkQUlYVzdMZmx1Q3lUSmZtNHdRN283?=
 =?utf-8?B?WmNzMFNweVlBU0NjUmMxck43YXc2WC92Q3BKVGdFZnZ4aGtkZ0NYMFhkdVRM?=
 =?utf-8?B?NGNRTEc3R2xtZ3BKcWVMblNqUUFUUGpMMjBQN2N1cnFmbnhjZW9leVZ3WUta?=
 =?utf-8?B?TjdvVUt4Z29HSzRKSkI5QnFuZ3A5QXllSjFYUnNIQmFTRkRkMkxnc2JMRFBy?=
 =?utf-8?B?ek5na2hXNW1kMTlxVlhBT2QvSkt3V1ZIcDVqUmZRYUxWTzRpS2tFVU1pMFlP?=
 =?utf-8?B?OXE5aFNSTFpOWU9TVzRadmozUFJ4bmhFdUZ4SlhCc0xia0ZGWitjMmtzakVQ?=
 =?utf-8?B?ZnJzSjZBQllXejZlWC9LYmYwUkhEYUFiUGphQTJFb2xYbkdlK0FtMjFUVVNu?=
 =?utf-8?B?K0V4eUpsRHk0OWxDTVhUQ1ZJTitRQlc5eG1HMHl4djBXNlhpZWFEWFFpODc4?=
 =?utf-8?B?SlZGenM5d1FFbUV5MkhQRTZiWXdpb1pKMWFVaTlQMjV2cE9lU1pOTnd2V25s?=
 =?utf-8?B?ZnFhVGhocy9leFIxWDhwTFpGSFFwL2svZUFnMVM4SFR3RlpyWVFEUkFxMDVa?=
 =?utf-8?B?RnZBMm5VazVTT3Z2eWsvTHpoelNmc0tTTjZwbmpRVEczUG5kWWhLeFhEbU9C?=
 =?utf-8?B?dGwrKy9uY1RtQlB2RFBJdlljQnRkazhReFU0aUZKZjBtckhxMjg5dWJYMlFt?=
 =?utf-8?B?UmhGbXhLTjhhY2p1S0ZiWENxamlkTnpkWnhDUVJJSC9IQ3d0V25lZGEzdUtH?=
 =?utf-8?B?M21QTnpmNlpYL1lRR2laV2JuLy9adGtYeWZxMzkvdWpkc3dKZktZNi9Pc3RW?=
 =?utf-8?B?TEIvZHpyUTJPVFBhSWdpWnd3VHFJWnNab2JMT3greHhHQ20xSVg0MVR4aVFz?=
 =?utf-8?B?aThxbUUzeTBEZm9NdEkwRjh1OUhTSXRDc3NYa1RSWkhQRjZUejZpSjZKSEt5?=
 =?utf-8?B?SmJwYzM3bjArcE10bERvQzRXYXV5c3B4bkJUV1VJUUNudktHK3JNdGlnRVk4?=
 =?utf-8?B?RXRiWWtPWG9kQ0t5SDd3Y2IyUTFZYzJtUGZjSlZUTnByYVh2VmJUbWxCUW11?=
 =?utf-8?B?MXBaaHJNOEdBa1JKYTRSaUNLSk03b001djFhR2UyTFpJVXhwb2M4VmtRTjNE?=
 =?utf-8?B?bDQ1dnBrcWVQQXlKMVl3WFZDckNhK2pOYWExVGhyZXJ0WkltRm1ibXdZenpr?=
 =?utf-8?Q?9CfA0DDyuj6WznVG7d?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf08447c-56f9-4ccc-1da9-08dec232976a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 12:12:47.7559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HYjtRGA1vVOl5kWVfPwWObc0Wdd+fEk8jg3pvoJlXE5HlFRLgzWOjzg/NwLucD7XrIR8yJVv3BwJPQCwvByyxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8494
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11165-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-pci@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Devendra.Verma@amd.com,dmaengine@vger.kernel.org];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Devendra.Verma@amd.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:from_mime,amd.com:email,sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4A8A63FCCC

UHVibGljDQoNClRoZSBwcmUtZXhpc3RpbmcgaXNzdWVzIG5lZWQgdG8gYmUgdGFrZW4gdXAgaW4g
YSBzZXBhcmF0ZSBzZXJpZXMuDQpUaGUgY2hhbmdlcyByZXF1aXJlIHNlcGFyYXRlIHRlc3Rpbmcg
d2hpY2ggaXMgbm90IHJlbGF0ZWQgdG8gdGhlDQpjdXJyZW50IHBhdGNoLg0KDQpSZWdhcmRzLA0K
RGV2ZW5kcmENCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBzYXNoaWtv
LWJvdEBrZXJuZWwub3JnIDxzYXNoaWtvLWJvdEBrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNk
YXksIEp1bmUgMywgMjAyNiAyMDoxNQ0KPiBUbzogVmVybWEsIERldmVuZHJhIDxEZXZlbmRyYS5W
ZXJtYUBhbWQuY29tPg0KPiBDYzogZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsgdmtvdWxAa2Vy
bmVsLm9yZzsgRnJhbmsuTGlAa2VybmVsLm9yZzsNCj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBkbWFlbmdpbmU6IGR3LWVkbWE6IEFkZCBYaWxp
bnggQ1BNNi1ETUENCj4gRGV2aWNlSUQNCj4NCj4gVGhhbmsgeW91IGZvciB5b3VyIGNvbnRyaWJ1
dGlvbiEgU2FzaGlrbyBBSSByZXZpZXcgZm91bmQgMSBwb3RlbnRpYWwgaXNzdWUocykNCj4gdG8g
Y29uc2lkZXI6DQo+DQo+IFByZS1leGlzdGluZyBpc3N1ZXM6DQo+IC0gW0hpZ2hdIE1pc3Npbmcg
cGNpX2ZyZWVfaXJxX3ZlY3RvcnMoKSBjbGVhbnVwIG9uIGVycm9yIHBhdGhzIGluDQo+IGR3X2Vk
bWFfcGNpZV9wcm9iZSgpIGxlYWRpbmcgdG8gSVJRIHJlc291cmNlIGxlYWtzLg0KPiAtLQ0KPg0K
PiBjb21taXQgYTUyMzQ2OGRiZTc5OTlhNTk2Mjg5NWMzZTBkNzM2NjJhMjkzODAwNg0KPiBBdXRo
b3I6IERldmVuZHJhIEsgVmVybWEgPGRldnZlcm1hQGFtZC5jb20+DQo+DQo+IGRtYWVuZ2luZTog
ZHctZWRtYTogQWRkIFhpbGlueCBDUE02LURNQSBEZXZpY2VJRA0KPg0KPiBBZGQgRGV2aWNlIElE
IGZvciBBTUQgKFhpbGlueCkgQ1BNNiBETUEgSVAgdG8gZW5hYmxlIDY0IFJlYWQgYW5kIDY0IFdy
aXRlDQo+IENoYW5uZWxzLiBBZGRzIHRoZSByZWxldmFudCBkd19lZG1hX3BjaWVfZGF0YSB0byB1
c2UgOCBSZWFkIGFuZCA4IFdyaXRlDQo+IENoYW5uZWxzIGZvciB0aGUgaW5pdGlhbCBjb21taXQu
DQo+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2R3LWVkbWEvZHctZWRtYS1wY2llLmMN
Cj4gPiBiL2RyaXZlcnMvZG1hL2R3LWVkbWEvZHctZWRtYS1wY2llLmMNCj4gPiBpbmRleCAwYjMw
Y2UxMzg1MDM2Li40YmEzNjhkMThjYjFkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZG1hL2R3
LWVkbWEvZHctZWRtYS1wY2llLmMNCj4gPiArKysgYi9kcml2ZXJzL2RtYS9kdy1lZG1hL2R3LWVk
bWEtcGNpZS5jDQo+DQo+IFsgLi4uIF0NCj4NCj4gPiBAQCAtNTQ3LDYgKzU2MSw4IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZA0KPiBkd19lZG1hX3BjaWVfaWRfdGFibGVbXSA9
IHsNCj4gPiAgICAgeyBQQ0lfREVWSUNFX0RBVEEoU1lOT1BTWVMsIEVEREEsICZzbnBzX2VkZGFf
ZGF0YSkgfSwNCj4gPiAgICAgeyBQQ0lfVkRFVklDRShYSUxJTlgsIFBDSV9ERVZJQ0VfSURfWElM
SU5YX0IwNTQpLA0KPiA+ICAgICAgIChrZXJuZWxfdWxvbmdfdCkmeGlsaW54X21kYl9kYXRhIH0s
DQo+ID4gKyAgIHsgUENJX1ZERVZJQ0UoWElMSU5YLCBQQ0lfREVWSUNFX0lEX1hJTElOWF9CMDBG
KSwNCj4gPiArICAgICAoa2VybmVsX3Vsb25nX3QpJnhpbGlueF9jcG02X2RtYV9kYXRhIH0sDQo+
DQo+IFtTZXZlcml0eTogSGlnaF0NCj4gVGhpcyBpcyBhIHByZS1leGlzdGluZyBpc3N1ZSwgYnV0
IGFkZGluZyB0aGlzIG5ldyBkZXZpY2UgSUQgZXhwb3NlcyB0aGUgbmV3DQo+IGRldmljZSB0byBh
biBJUlEgcmVzb3VyY2UgbGVhayBpbiBkd19lZG1hX3BjaWVfcHJvYmUoKS4NCj4NCj4gV2hlbiB0
aGUgZGV2aWNlIGlzIHByb2JlZCwgZHdfZWRtYV9wY2llX3Byb2JlKCkgc3VjY2Vzc2Z1bGx5IGFs
bG9jYXRlcw0KPiBJUlFzIHZpYSBwY2lfYWxsb2NfaXJxX3ZlY3RvcnMoKS4gSG93ZXZlciwgc2V2
ZXJhbCBzdWJzZXF1ZW50IGVycm9yIHBhdGhzDQo+IHJldHVybiBkaXJlY3RseSB3aXRob3V0IGNh
bGxpbmcgcGNpX2ZyZWVfaXJxX3ZlY3RvcnMoKS4NCj4NCj4gRm9yIGV4YW1wbGUsIGlmIHRoZSBw
Y2ltX2lvbWFwX3RhYmxlKCkgbG9va3VwIGZhaWxzOg0KPg0KPiBkcml2ZXJzL2RtYS9kdy1lZG1h
L2R3LWVkbWEtcGNpZS5jOmR3X2VkbWFfcGNpZV9wcm9iZSgpIHsNCj4gICAgIC4uLg0KPiAgICAg
ICBjaGlwLT5yZWdfYmFzZSA9IHBjaW1faW9tYXBfdGFibGUocGRldilbdnNlY19kYXRhLT5yZy5i
YXJdOw0KPiAgICAgICBpZiAoIWNoaXAtPnJlZ19iYXNlKQ0KPiAgICAgICAgICAgICAgIHJldHVy
biAtRU5PTUVNOw0KPiAgICAgLi4uDQo+IH0NCj4NCj4gT3IgaWYgdGhlIG1haW4gZURNQSBwcm9i
ZSBmYWlscyBsYXRlciBvbjoNCj4NCj4gZHJpdmVycy9kbWEvZHctZWRtYS9kdy1lZG1hLXBjaWUu
Yzpkd19lZG1hX3BjaWVfcHJvYmUoKSB7DQo+ICAgICAuLi4NCj4gICAgICAgZXJyID0gZHdfZWRt
YV9wcm9iZShjaGlwKTsNCj4gICAgICAgaWYgKGVycikgew0KPiAgICAgICAgICAgICAgIHBjaV9l
cnIocGRldiwgImVETUEgcHJvYmUgZmFpbGVkXG4iKTsNCj4gICAgICAgICAgICAgICByZXR1cm4g
ZXJyOw0KPiAgICAgICB9DQo+ICAgICAuLi4NCj4gfQ0KPg0KPiBEb2VzIHRoaXMgY29kZSBsZWFr
IHRoZSBhbGxvY2F0ZWQgSVJRIHZlY3RvcnMgaW4gdGhlc2UgZXJyb3IgcGF0aHM/IEJlY2F1c2UN
Cj4gSVJRcyBhcmUgYSBzdHJpY3RseSBsaW1pdGVkIHJlc291cmNlLCByZXBlYXRlZCBwcm9iZSBm
YWlsdXJlcyAoc3VjaCBhcyBkZWZlcnJlZA0KPiBwcm9iZSBvciB1bmJpbmQvcmViaW5kIGN5Y2xl
cykgY291bGQgc2lsZW50bHkgZXhoYXVzdCB0aGUgc3lzdGVtJ3MgSVJRDQo+IGNhcGFjaXR5Lg0K
Pg0KPiBXb3VsZCBpdCBtYWtlIHNlbnNlIHRvIGVuc3VyZSBwY2lfZnJlZV9pcnFfdmVjdG9ycygp
IGlzIGNhbGxlZCBvbiBhbGwgZXJyb3INCj4gcGF0aHMgYWZ0ZXIgc3VjY2Vzc2Z1bCBhbGxvY2F0
aW9uIGJlZm9yZSBlbmFibGluZyBuZXcgZGV2aWNlcz8NCj4NCj4gPiAgICAgeyB9DQo+ID4gIH07
DQo+ID4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUocGNpLCBkd19lZG1hX3BjaWVfaWRfdGFibGUpOw0K
Pg0KPiAtLQ0KPiBTYXNoaWtvIEFJIHJldmlldyDCtyBodHRwczovL3Nhc2hpa28uZGV2LyMvcGF0
Y2hzZXQvMjAyNjA2MDMxNDMxNTguMzI0MzUwMC0NCj4gMS1kZXZlbmRyYS52ZXJtYUBhbWQuY29t
P3BhcnQ9MQ0K

